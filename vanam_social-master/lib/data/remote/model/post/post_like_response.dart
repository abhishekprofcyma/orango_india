// To parse this JSON data, do
//
//     final postLikeResponse = postLikeResponseFromJson(jsonString);

import 'dart:convert';

PostLikeResponse postLikeResponseFromJson(String str) => PostLikeResponse.fromJson(json.decode(str));

String postLikeResponseToJson(PostLikeResponse data) => json.encode(data.toJson());

class PostLikeResponse {
  PostLikeResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory PostLikeResponse.fromJson(Map<String, dynamic> json) => PostLikeResponse(
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
