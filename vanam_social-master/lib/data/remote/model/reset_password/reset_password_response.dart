
import 'dart:convert';

ResetPasswordResponse resetPasswordResponseFromJson(String str) => ResetPasswordResponse.fromJson(json.decode(str));

String resetPasswordResponseToJson(ResetPasswordResponse data) => json.encode(data.toJson());

class ResetPasswordResponse {
  ResetPasswordResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  bool data;
  String message;

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) => ResetPasswordResponse(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : json["data"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data,
    "message": message == null ? null : message,
  };
}
