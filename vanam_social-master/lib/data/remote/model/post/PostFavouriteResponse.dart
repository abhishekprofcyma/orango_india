// To parse this JSON data, do
//
//     final postFavouriteResponse = postFavouriteResponseFromJson(jsonString);

import 'dart:convert';

PostFavouriteResponse postFavouriteResponseFromJson(String str) => PostFavouriteResponse.fromJson(json.decode(str));

String postFavouriteResponseToJson(PostFavouriteResponse data) => json.encode(data.toJson());

class PostFavouriteResponse {
  PostFavouriteResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory PostFavouriteResponse.fromJson(Map<String, dynamic> json) => PostFavouriteResponse(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data!.toJson(),
    "message": message,
  };
}

class Data {
  Data({
    required this.post,
  });

  String? post;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    post: json["post"],
  );

  Map<String, dynamic> toJson() => {
    "post": post,
  };
}
