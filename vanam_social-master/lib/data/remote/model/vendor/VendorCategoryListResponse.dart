// To parse this JSON data, do
//
//     final vendorCategoryListResponse = vendorCategoryListResponseFromJson(jsonString?);

import 'dart:convert';

VendorCategoryListResponse vendorCategoryListResponseFromJson(String? str) => VendorCategoryListResponse.fromJson(json.decode(str!));

String? vendorCategoryListResponseToJson(VendorCategoryListResponse data) => json.encode(data.toJson());

class VendorCategoryListResponse {
  VendorCategoryListResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  bool? success;
  Data data;
  String? message;

  factory VendorCategoryListResponse.fromJson(Map<String?, dynamic> json) => VendorCategoryListResponse(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String?, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "message": message,
  };
}

class Data {
  Data({
    required this.category,
  });

  List<Category> category;

  factory Data.fromJson(Map<String?, dynamic> json) => Data(
    category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
  );

  Map<String?, dynamic> toJson() => {
    "category": List<dynamic>.from(category.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    required this.id,
    required this.userId,
    required this.name,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  int? id;
  int? userId;
  String? name;
  String? image;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory Category.fromJson(Map<String?, dynamic> json) => Category(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    image: json["image"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String?, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "image": image,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
  };
}