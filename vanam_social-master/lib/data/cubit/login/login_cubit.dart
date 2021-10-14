import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vanam_social/data/local/shared_pref.dart';
import 'package:vanam_social/data/remote/model/login/login_fail_response.dart';
import 'package:vanam_social/data/remote/model/login/login_response.dart';
import 'package:vanam_social/data/remote/repository.dart';
import 'package:vanam_social/main.dart';
import 'package:vanam_social/screens/home/home_screen.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState>{
  Repository _repository = Repository();


  LoginCubit(LoginState state) : super(state);


  fetchLogin(BuildContext context,String mobileEmail,String password,String firebaseToken) async {
    var map = Map<String,String>();
    map['mobile_email'] = mobileEmail;
    map['password'] = password;
    map['device_key'] = firebaseToken;
    emit(LoginLoading());
    try {
      LoginResponse loginResponse =
      await _repository.fetchLoginDetails(context,map);
      if(loginResponse.success!){
        saveToken("Bearer ${loginResponse.data!.token}");
        saveLogin(true);
        saveUserId(loginResponse.data!.userId.toString());
        saveUserName(loginResponse.data!.name.toString());
        saveMobile(loginResponse.data!.mobile.toString());
        emit(LoginLoaded(login: loginResponse));
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
        Fluttertoast.showToast(msg: "Login successfully");
        manageLoginActivity(context,loginResponse);
      }else{
        Fluttertoast.showToast(msg: "Login failed");
      }
    } catch (e) {
      print("error: ${e.toString()}");
      Fluttertoast.showToast(msg: "${LoginFailResponse.fromJson(json.decode(e.toString())).message}");
      emit(LoginError(e.toString().replaceAll("Invalid Input: 401", "")));
      print(e);
    }
  }

  manageLoginActivity(BuildContext context,LoginResponse loginResponse)async{
    String id = await getDeviceId();
    String deviceName = await getDeviceName();
    String deviceModel = await getDeviceModel();
    DatabaseReference reference=
        FirebaseDatabase.instance.reference().child("login").child(loginResponse.data?.userId.toString()??"");
    reference.push().set({
      'device_id': id,
      'device_name': deviceName,
      'device_model': deviceModel,
      'created_time': DateTime.now().toString(),
    });
  }



}