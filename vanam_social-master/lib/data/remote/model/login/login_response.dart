// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString?);


import 'dart:convert';

LoginResponse loginResponseFromJson(String? str) => LoginResponse.fromJson(json.decode(str??""));

String? loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory LoginResponse.fromJson(Map<String?, dynamic> json) => LoginResponse(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String?, dynamic> toJson() => {
    "success": success,
    "data": data!.toJson(),
    "message": message,
  };
}

class Data {
  Data({
    required this.token,
    required this.name,
    required this.mobile,
    required this.userId,
  });

  String? token;
  String? name;
  String? mobile;
  int? userId;

  factory Data.fromJson(Map<String?, dynamic> json) => Data(
    token: json["token"],
    name: json["name"],
    mobile: json["mobile"],
    userId: json["user_id"],
  );

  Map<String?, dynamic> toJson() => {
    "token": token,
    "name": name,
    "mobile": mobile,
    "user_id": userId,
  };
}
