// To parse this JSON data, do
//
//     final postCommentResponse = postCommentResponseFromJson(jsonString);

import 'dart:convert';

PostCommentResponse postCommentResponseFromJson(String str) => PostCommentResponse.fromJson(json.decode(str));

String postCommentResponseToJson(PostCommentResponse data) => json.encode(data.toJson());

class PostCommentResponse {
  PostCommentResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data? data;
  String message;

  factory PostCommentResponse.fromJson(Map<String, dynamic> json) => PostCommentResponse(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data!.toJson(),
    "message": message == null ? null : message,
  };
}

class Data {
  Data({
    required this.post,
  });

  String post;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    post: json["post"] == null ? null : json["post"],
  );

  Map<String, dynamic> toJson() => {
    "post": post == null ? null : post,
  };
}
