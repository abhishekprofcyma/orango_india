// To parse this JSON data, do
//
//     final connectionDenyResponse = connectionDenyResponseFromJson(jsonString);


import 'dart:convert';

ConnectionDenyResponse connectionDenyResponseFromJson(String str) => ConnectionDenyResponse.fromJson(json.decode(str));

String connectionDenyResponseToJson(ConnectionDenyResponse data) => json.encode(data.toJson());

class ConnectionDenyResponse {
  ConnectionDenyResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory ConnectionDenyResponse.fromJson(Map<String, dynamic> json) => ConnectionDenyResponse(
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
