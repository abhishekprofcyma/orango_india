// To parse this JSON data, do
//
//     final postShareWithResponse = postShareWithResponseFromJson(jsonString);

import 'dart:convert';

PostShareWithResponse postShareWithResponseFromJson(String str) => PostShareWithResponse.fromJson(json.decode(str));

String postShareWithResponseToJson(PostShareWithResponse data) => json.encode(data.toJson());

class PostShareWithResponse {
  PostShareWithResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory PostShareWithResponse.fromJson(Map<String, dynamic> json) => PostShareWithResponse(
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
    required this.shareWith,
  });

  List<ShareWith> shareWith = [];

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    shareWith: List<ShareWith>.from(json["share_with"].map((x) => ShareWith.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "share_with": List<dynamic>.from(shareWith.map((x) => x.toJson())),
  };
}

class ShareWith {
  ShareWith({
    required this.id,
    required this.userId,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  int? id;
  int? userId;
  String? name;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory ShareWith.fromJson(Map<String, dynamic> json) => ShareWith(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
