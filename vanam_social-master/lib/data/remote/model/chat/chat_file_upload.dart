// To parse this JSON data, do
//
//     final chatFileUploadResponse = chatFileUploadResponseFromJson(jsonString);


import 'dart:convert';

ChatFileUploadResponse chatFileUploadResponseFromJson(String str) => ChatFileUploadResponse.fromJson(json.decode(str));

String chatFileUploadResponseToJson(ChatFileUploadResponse data) => json.encode(data.toJson());

class ChatFileUploadResponse {
  ChatFileUploadResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data? data;
  String message;

  factory ChatFileUploadResponse.fromJson(Map<String, dynamic> json) => ChatFileUploadResponse(
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
    required this.url,
  });

  String url;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    url: json["url"] == null ? null : json["url"],
  );

  Map<String, dynamic> toJson() => {
    "url": url == null ? null : url,
  };
}
