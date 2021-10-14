// To parse this JSON data, do
//
//     final postRecommentResponse = postRecommentResponseFromJson(jsonString);

import 'dart:convert';

PostRecommentResponse postRecommentResponseFromJson(String str) => PostRecommentResponse.fromJson(json.decode(str));

String postRecommentResponseToJson(PostRecommentResponse data) => json.encode(data.toJson());

class PostRecommentResponse {
  PostRecommentResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory PostRecommentResponse.fromJson(Map<String, dynamic> json) => PostRecommentResponse(
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
