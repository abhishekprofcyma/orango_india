// To parse this JSON data, do
//
//     final momentAddResponse = momentAddResponseFromJson(jsonString);


import 'dart:convert';

MomentAddResponse momentAddResponseFromJson(String str) => MomentAddResponse.fromJson(json.decode(str));

String momentAddResponseToJson(MomentAddResponse data) => json.encode(data.toJson());

class MomentAddResponse {
  MomentAddResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory MomentAddResponse.fromJson(Map<String, dynamic> json) => MomentAddResponse(
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
    required this.moment,
  });

  String? moment;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    moment: json["moment"],
  );

  Map<String, dynamic> toJson() => {
    "moment": moment,
  };
}
