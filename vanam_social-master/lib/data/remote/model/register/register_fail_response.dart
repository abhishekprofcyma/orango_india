// To parse this JSON data, do
//
//     final registerErrorResponse = registerErrorResponseFromJson(jsonString);


import 'dart:convert';

RegisterErrorResponse registerErrorResponseFromJson(String str) => RegisterErrorResponse.fromJson(json.decode(str));

String registerErrorResponseToJson(RegisterErrorResponse data) => json.encode(data.toJson());

class RegisterErrorResponse {
  RegisterErrorResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory RegisterErrorResponse.fromJson(Map<String, dynamic> json) => RegisterErrorResponse(
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    required this.email,
    required this.mobileNumber,
  });

  List<String>? email;
  List<String>? mobileNumber;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    email: List<String>.from(json["email"].map((x) => x)),
    mobileNumber: List<String>.from(json["mobile_number"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "email": List<dynamic>.from(email!.map((x) => x)),
    "mobile_number": List<dynamic>.from(mobileNumber!.map((x) => x)),
  };
}
