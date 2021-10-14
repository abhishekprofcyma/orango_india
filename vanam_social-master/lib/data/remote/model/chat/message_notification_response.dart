// To parse this JSON data, do
//
//     final messageNotificationResponse = messageNotificationResponseFromJson(jsonString);


import 'dart:convert';

MessageNotificationResponse messageNotificationResponseFromJson(String str) => MessageNotificationResponse.fromJson(json.decode(str));

String messageNotificationResponseToJson(MessageNotificationResponse data) => json.encode(data.toJson());

class MessageNotificationResponse {
  MessageNotificationResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory MessageNotificationResponse.fromJson(Map<String, dynamic> json) => MessageNotificationResponse(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
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
