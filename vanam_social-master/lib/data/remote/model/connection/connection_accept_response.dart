// To parse this JSON data, do
//
//     final connectionAcceptResponse = connectionAcceptResponseFromJson(jsonString);


import 'dart:convert';

ConnectionAcceptResponse connectionAcceptResponseFromJson(String str) => ConnectionAcceptResponse.fromJson(json.decode(str));

String connectionAcceptResponseToJson(ConnectionAcceptResponse data) => json.encode(data.toJson());

class ConnectionAcceptResponse {
  ConnectionAcceptResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory ConnectionAcceptResponse.fromJson(Map<String, dynamic> json) => ConnectionAcceptResponse(
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

  int? post;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    post: json["post"],
  );

  Map<String, dynamic> toJson() => {
    "post": post,
  };
}
