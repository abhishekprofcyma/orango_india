// To parse this JSON data, do
//
//     final vendorSubscribeResponse = vendorSubscribeResponseFromJson(jsonString?);

import 'dart:convert';

VendorSubscribeResponse vendorSubscribeResponseFromJson(String? str) => VendorSubscribeResponse.fromJson(json.decode(str??""));

String? vendorSubscribeResponseToJson(VendorSubscribeResponse data) => json.encode(data.toJson());

class VendorSubscribeResponse {
  VendorSubscribeResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory VendorSubscribeResponse.fromJson(Map<String?, dynamic> json) => VendorSubscribeResponse(
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
    required this.moment,
  });

  String? moment;

  factory Data.fromJson(Map<String?, dynamic> json) => Data(
    moment: json["moment"],
  );

  Map<String?, dynamic> toJson() => {
    "moment": moment,
  };
}
