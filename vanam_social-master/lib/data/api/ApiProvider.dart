

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:vanam_social/data/local/shared_pref.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';

import '../../constants.dart';
import 'CustomException.dart';

class ApiProvider {

  Future<dynamic> get(BuildContext context,String url,Map<String,String> map) async {
    var mapHeader = new Map<String, String>();
    mapHeader['Authorization'] = (await getToken());
    mapHeader['Accept'] = "application/json";
    print("param : $mapHeader");
    var responseJson;
    try {
      var uri = IsProduction ?  Uri.https(BaseUrlTest ,BaseShortUrl+url,map) : Uri.http(BaseUrlTest ,BaseShortUrl+url,map);
      print("request: $uri $url - $mapHeader");
      final response = await http.get(uri,headers: mapHeader);
      print("response: $uri $url - $map ${response.body}");
      responseJson = _response(context,response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(BuildContext context,String url,Map<String,String> map) async {
    var mapHeader = new Map<String, String>();
    mapHeader['Authorization'] = await getToken();
    mapHeader['Accept'] = "application/json";
    var responseJson;
    try {
      var uri = IsProduction ?  Uri.https(BaseUrlTest ,BaseShortUrl+url) : Uri.http(BaseUrlTest ,BaseShortUrl+url);
      print("request: $uri $url - $map");
      final response = await http.post(uri,body: map,headers: mapHeader);
      print("response:$uri $url - $map ${response.body}");
      responseJson = _response(context,response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(BuildContext context,String url,Map<String,String> map) async {
    var mapHeader = new Map<String, String>();
    mapHeader['Authorization'] = await getToken();
    mapHeader['Accept'] = "application/json";
    var responseJson;
    try {
      var uri = IsProduction ?  Uri.https(BaseUrlTest ,BaseShortUrl+url) : Uri.http(BaseUrlTest ,BaseShortUrl+url);
      print("request: $uri $url - $map");
      final response = await http.delete(uri,body: map,headers: mapHeader);
      print("response: $uri $url - $map ${response.body}");
      responseJson = _response(context,response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postMultipart(context,String url,Map<String,String> map,List<File> files) async {
    var mapHeader = new Map<String, String>();
    mapHeader['Authorization'] = (await getToken());
    mapHeader['Accept'] = "application/json";
    var responseJson;
    try {
      var uri = IsProduction ? "https://"+BaseUrlTest +BaseShortUrl+url :  "http://"+BaseUrlTest+BaseShortUrl+url;

      print("request: $uri - $map");
      var dio = Dio();

      var formData = FormData();
      map.forEach((key, value) {
        formData.fields.add(MapEntry(key, value));
      });
      int imageCount = -1;
      int videoCount = -1;
      files.asMap().forEach((key, value) async{
        var extension = files[key].path.split("/").last.split(".").last;
        if(IMAGE_EXTENSION_ALLOW.contains(extension)) {
          imageCount++;
          formData.files.addAll([
            MapEntry("image[$imageCount]",
                await MultipartFile.fromFile(value.path, filename: value.path
                    .split("/")
                    .last))
          ]);
        }else if(VIDEO_EXTENSION_ALLOW.contains(extension)){
          videoCount++;
          formData.files.addAll([
            MapEntry("video[$videoCount]",
                await MultipartFile.fromFile(value.path, filename: value.path
                    .split("/")
                    .last))
          ]);
        }
      });

      var response = await dio.post(uri, data: formData,options:Options(headers: mapHeader) );
      print("response: ${response.toString()}");
      responseJson = _response1(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postMultipartFile(context,String url,Map<String,String> map,List<File> files) async {
    var mapHeader = new Map<String, String>();
    mapHeader['Authorization'] = (await getToken());
    mapHeader['Accept'] = "application/json";
    var responseJson;
    try {
      var uri = IsProduction ?  "https://"+BaseUrlTest +BaseShortUrl+url :  "http://"+BaseUrlTest+BaseShortUrl+url;
      print("request: $uri - $map");
      var dio = Dio();

      var formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(files[0].path, filename: files[0].path.split("/").last),
      });
      var response = await dio.post(uri, data: formData,options:Options(headers: mapHeader) );
      print("response: ${response.data.toString()}");
      responseJson = _response1(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  //for all
  Future<dynamic> postMultipartFiles(String url,Map<String,String> map,List<MapEntry<String,MultipartFile>> fileMapEntry) async {
    var mapHeader = new Map<String, String>();
    mapHeader['Authorization'] = (await getToken());
    mapHeader['Accept'] = "application/json";
    var responseJson;
    try {
      var uri = IsProduction ?  "https://"+BaseUrlTest +BaseShortUrl+url :  "http://"+BaseUrlTest+BaseShortUrl+url;
      print("request: $uri - $map");
      var dio = Dio();

      var formData = FormData();
      map.forEach((key, value) {
        formData.fields.add(MapEntry(key, value));
      });
      formData.files.addAll(fileMapEntry);
      var response = await dio.post(uri, data: formData,options:Options(headers: mapHeader) );
      print("response: ${response.data.toString()}");
      responseJson = _response1(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }


  dynamic _response(BuildContext context,http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 404:
         throw InvalidInputException(response.body.toString());
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw BadRequestException(response.body.toString());
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        throw BadRequestException(response.body.toString());
      case 202:
        throw BadRequestException(response.body.toString());
      case 503:
        throw BadRequestException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  dynamic _response1(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.toString());
        print(responseJson);
        return responseJson;
      case 404:
        //throw InvalidInputException(ErrorResponse.fromJson(json.decode(response.data)).data.toString()+ErrorResponse.fromJson(json.decode(response.data)).message.toString());
      case 400:
        throw BadRequestException(response.data.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.data.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }


}