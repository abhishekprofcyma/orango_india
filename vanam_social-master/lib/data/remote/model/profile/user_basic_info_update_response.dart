// To parse this JSON data, do
//
//     final userBasicInfoUpdateResponse = userBasicInfoUpdateResponseFromJson(jsonString);

import 'dart:convert';

UserBasicInfoUpdateResponse userBasicInfoUpdateResponseFromJson(String str) => UserBasicInfoUpdateResponse.fromJson(json.decode(str));

String userBasicInfoUpdateResponseToJson(UserBasicInfoUpdateResponse data) => json.encode(data.toJson());

class UserBasicInfoUpdateResponse {
  UserBasicInfoUpdateResponse({
    required this.success,
    required this.message,
  });

  bool? success;
  String? message;

  factory UserBasicInfoUpdateResponse.fromJson(Map<String, dynamic> json) => UserBasicInfoUpdateResponse(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
