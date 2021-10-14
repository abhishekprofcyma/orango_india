// To parse this JSON data, do
//
//     final profileUploadResponse = profileUploadResponseFromJson(jsonString);

import 'dart:convert';

ProfileUploadResponse profileUploadResponseFromJson(String str) => ProfileUploadResponse.fromJson(json.decode(str));

String profileUploadResponseToJson(ProfileUploadResponse data) => json.encode(data.toJson());

class ProfileUploadResponse {
  ProfileUploadResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory ProfileUploadResponse.fromJson(Map<String, dynamic> json) => ProfileUploadResponse(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data!.toJson(),
    "message": message == null ? null : message,
  };
}

class Data {
  Data({
    required this.basicinfo,
  });

  Basicinfo? basicinfo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    basicinfo: json["basicinfo"] == null ? null : Basicinfo.fromJson(json["basicinfo"]),
  );

  Map<String, dynamic> toJson() => {
    "basicinfo": basicinfo == null ? null : basicinfo!.toJson(),
  };
}

class Basicinfo {
  Basicinfo({
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  String? image;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory Basicinfo.fromJson(Map<String, dynamic> json) => Basicinfo(
    image: json["image"] == null ? null : json["image"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "image": image == null ? null : image,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
