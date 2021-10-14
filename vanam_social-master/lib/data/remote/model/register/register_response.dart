// To parse this JSON data, do
//
//     final registerRespnse = registerRespnseFromJson(jsonString?);

import 'dart:convert';

RegisterRespnse registerRespnseFromJson(String? str) => RegisterRespnse.fromJson(json.decode(str??""));

String? registerRespnseToJson(RegisterRespnse data) => json.encode(data.toJson());

class RegisterRespnse {
  RegisterRespnse({
    required this.success,
    required this.data,
    required this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory RegisterRespnse.fromJson(Map<String?, dynamic> json) => RegisterRespnse(
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
    required this.userId,
  });

  String? token;
  String? name;
  int? userId;

  factory Data.fromJson(Map<String?, dynamic> json) => Data(
    token: json["token"],
    name: json["name"],
    userId: json["user_id"],
  );

  Map<String?, dynamic> toJson() => {
    "token": token,
    "name": name,
    "user_id": userId,
  };
}
