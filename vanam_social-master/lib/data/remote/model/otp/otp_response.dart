// To parse this JSON data, do
//
//     final otpResponse = otpResponseFromJson(jsonString);


import 'dart:convert';

OtpResponse otpResponseFromJson(String str) => OtpResponse.fromJson(json.decode(str));

String otpResponseToJson(OtpResponse data) => json.encode(data.toJson());

class OtpResponse {
  OtpResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  bool? success;
  dynamic? data;
  String message;

  factory OtpResponse.fromJson(Map<String, dynamic> json) => OtpResponse(
    success: json["success"],
    data: json["data"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data,
    "message": message,
  };
}
