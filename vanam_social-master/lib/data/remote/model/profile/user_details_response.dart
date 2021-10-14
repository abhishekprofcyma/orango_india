// To parse this JSON data, do
//
//     final userDetailResponse = userDetailResponseFromJson(jsonString?);

import 'dart:convert';

UserDetailResponse userDetailResponseFromJson(String? str) => UserDetailResponse.fromJson(json.decode(str!));

String? userDetailResponseToJson(UserDetailResponse data) => json.encode(data.toJson());

class UserDetailResponse {
  UserDetailResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory UserDetailResponse.fromJson(Map<String?, dynamic> json) => UserDetailResponse(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.mobileNumber,
    required this.emailVerifiedAt,
    required this.type,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.deviceKey,
    required this.deviceToken,
    required this.connectionCount,
    required this.userBasicInfo,
  });

  int? id;
  String? name;
  String? email;
  String? gender;
  String? mobileNumber;
  dynamic emailVerifiedAt;
  String? type;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? deviceKey;
  dynamic deviceToken;
  dynamic? connectionCount;
  UserBasicInfo? userBasicInfo;

  factory Data.fromJson(Map<String?, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    gender: json["gender"],
    mobileNumber: json["mobile_number"],
    emailVerifiedAt: json["email_verified_at"],
    type: json["type"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    deviceKey: json["device_key"],
    deviceToken: json["device_token"],
    connectionCount: json["connection_count"] == null ? null : json["connection_count"],
    userBasicInfo: json["user_basic_info"] == null ? null :  UserBasicInfo.fromJson(json["user_basic_info"]),
  );

  Map<String?, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "gender": gender,
    "mobile_number": mobileNumber,
    "email_verified_at": emailVerifiedAt,
    "type": type,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "device_key": deviceKey,
    "device_token": deviceToken,
    "connection_count": connectionCount == null ? null : connectionCount,
    "user_basic_info": userBasicInfo == null ? null : userBasicInfo?.toJson(),
  };
}

class UserBasicInfo {
  UserBasicInfo({
    required this.id,
    required this.userId,
    required this.homeCity,
    required this.currentCity,
    required this.gender,
    required this.language,
    required this.interests,
    required this.relationship,
    required this.dob,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  int? id;
  int? userId;
  String? homeCity;
  String? currentCity;
  String? gender;
  String? language;
  String? interests;
  String? relationship;
  String? dob;
  String? image;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory UserBasicInfo.fromJson(Map<String?, dynamic> json) => UserBasicInfo(
    id: json["id"],
    userId: json["user_id"],
    homeCity: json["home_city"],
    currentCity: json["current_city"],
    gender: json["gender"],
    language: json["language"],
    interests: json["interests"],
    relationship: json["relationship"],
    dob: json["dob"],
    image: json["image"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String?, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "home_city": homeCity,
    "current_city": currentCity,
    "gender": gender,
    "language": language,
    "interests": interests,
    "relationship": relationship,
    "dob": dob,
    "image": image,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
  };
}



//// To parse this JSON data, do
// //
// //     final userDetailResponse = userDetailResponseFromJson(jsonString);
//
//
// import 'dart:convert';
//
// UserDetailResponse userDetailResponseFromJson(String str) => UserDetailResponse.fromJson(json.decode(str));
//
// String userDetailResponseToJson(UserDetailResponse data) => json.encode(data.toJson());
//
// class UserDetailResponse {
//     UserDetailResponse({
//         @required this.success,
//         @required this.data,
//         @required this.message,
//     });
//
//     bool success;
//     Data data;
//     String message;
//
//     factory UserDetailResponse.fromJson(Map<String, dynamic> json) => UserDetailResponse(
//         success: json["success"] == null ? null : json["success"],
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//         message: json["message"] == null ? null : json["message"],
//     );
//
//     Map<String, dynamic> toJson() => {
//         "success": success == null ? null : success,
//         "data": data == null ? null : data.toJson(),
//         "message": message == null ? null : message,
//     };
// }
//
// class Data {
//     Data({
//         @required this.id,
//         @required this.name,
//         @required this.email,
//         @required this.gender,
//         @required this.mobileNumber,
//         @required this.emailVerifiedAt,
//         @required this.type,
//         @required this.status,
//         @required this.createdAt,
//         @required this.updatedAt,
//         @required this.deletedAt,
//         @required this.deviceKey,
//         @required this.deviceToken,
//         @required this.userBasicInfo,
//     });
//
//     int id;
//     String name;
//     String email;
//     String gender;
//     String mobileNumber;
//     dynamic emailVerifiedAt;
//     String type;
//     bool status;
//     DateTime createdAt;
//     DateTime updatedAt;
//     dynamic deletedAt;
//     String deviceKey;
//     dynamic deviceToken;
//     dynamic userBasicInfo;
//
//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         id: json["id"] == null ? null : json["id"],
//         name: json["name"] == null ? null : json["name"],
//         email: json["email"] == null ? null : json["email"],
//         gender: json["gender"] == null ? null : json["gender"],
//         mobileNumber: json["mobile_number"] == null ? null : json["mobile_number"],
//         emailVerifiedAt: json["email_verified_at"],
//         type: json["type"] == null ? null : json["type"],
//         status: json["status"] == null ? null : json["status"],
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//         deletedAt: json["deleted_at"],
//         deviceKey: json["device_key"] == null ? null : json["device_key"],
//         deviceToken: json["device_token"],
//         userBasicInfo: json["user_basic_info"],
//     );
//
//     Map<String, dynamic> toJson() => {
//         "id": id == null ? null : id,
//         "name": name == null ? null : name,
//         "email": email == null ? null : email,
//         "gender": gender == null ? null : gender,
//         "mobile_number": mobileNumber == null ? null : mobileNumber,
//         "email_verified_at": emailVerifiedAt,
//         "type": type == null ? null : type,
//         "status": status == null ? null : status,
//         "created_at": createdAt == null ? null : createdAt.toIso8601String(),
//         "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
//         "deleted_at": deletedAt,
//         "device_key": deviceKey == null ? null : deviceKey,
//         "device_token": deviceToken,
//         "user_basic_info": userBasicInfo,
//     };
// }