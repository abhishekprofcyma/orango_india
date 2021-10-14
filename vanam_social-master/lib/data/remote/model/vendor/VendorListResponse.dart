// To parse this JSON data, do
//
//     final vendorListResponse = vendorListResponseFromJson(jsonString?);

import 'dart:convert';

VendorListResponse vendorListResponseFromJson(String? str) => VendorListResponse.fromJson(json.decode(str??""));

String? vendorListResponseToJson(VendorListResponse data) => json.encode(data.toJson());

class VendorListResponse {
  VendorListResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory VendorListResponse.fromJson(Map<String?, dynamic> json) => VendorListResponse(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"] == null ? null : json["message"],
  );

  Map<String?, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data!.toJson(),
    "message": message == null ? null : message,
  };
}

class Data {
  Data({
    required this.vendor,
    required this.userSubscipation,
  });

  Vendor? vendor;
  List<UserSubscipation>? userSubscipation;

  factory Data.fromJson(Map<String?, dynamic> json) => Data(
    vendor: json["vendor"] == null ? null : Vendor.fromJson(json["vendor"]),
    userSubscipation: json["user_subscipation"] == null ? null : List<UserSubscipation>.from(json["user_subscipation"].map((x) => UserSubscipation.fromJson(x))),
  );

  Map<String?, dynamic> toJson() => {
    "vendor": vendor == null ? null : vendor!.toJson(),
    "user_subscipation": userSubscipation == null ? null : List<dynamic>.from(userSubscipation!.map((x) => x.toJson())),
  };
}

class UserSubscipation {
  UserSubscipation({
    required this.id,
    required this.userId,
    required this.subscriptionId,
    required this.price,
    required this.type,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.vendorSubscription,
  });

  int? id;
  int? userId;
  int? subscriptionId;
  String? price;
  String? type;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  VendorSubscriptionPlan? vendorSubscription;

  factory UserSubscipation.fromJson(Map<String?, dynamic> json) => UserSubscipation(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    subscriptionId: json["subscription_id"] == null ? null : json["subscription_id"],
    price: json["price"] == null ? null : json["price"],
    type: json["type"] == null ? null : json["type"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    vendorSubscription: json["vendor_subscription"] == null ? null : VendorSubscriptionPlan.fromJson(json["vendor_subscription"]),
  );

  Map<String?, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "subscription_id": subscriptionId == null ? null : subscriptionId,
    "price": price == null ? null : price,
    "type": type == null ? null : type,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
    "vendor_subscription": vendorSubscription == null ? null : vendorSubscription!.toJson(),
  };
}

class VendorSubscriptionPlan {
  VendorSubscriptionPlan({
    required this.id,
    required this.vendorId,
    required this.planId,
    required this.price,
    required this.features,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  int? id;
  int? vendorId;
  int? planId;
  String? price;
  String? features;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory VendorSubscriptionPlan.fromJson(Map<String?, dynamic> json) => VendorSubscriptionPlan(
    id: json["id"] == null ? null : json["id"],
    vendorId: json["vendor_id"] == null ? null : json["vendor_id"],
    planId: json["plan_id"] == null ? null : json["plan_id"],
    price: json["price"] == null ? null : json["price"],
    features: json["features"] == null ? null : json["features"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String?, dynamic> toJson() => {
    "id": id == null ? null : id,
    "vendor_id": vendorId == null ? null : vendorId,
    "plan_id": planId == null ? null : planId,
    "price": price == null ? null : price,
    "features": features == null ? null : features,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
  };
}

class Vendor {
  Vendor({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  int? currentPage;
  List<VendorItem>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory Vendor.fromJson(Map<String?, dynamic> json) => Vendor(
    currentPage: json["current_page"] == null ? null : json["current_page"],
    data: json["data"] == null ? null : List<VendorItem>.from(json["data"].map((x) => VendorItem.fromJson(x))),
    firstPageUrl: json["first_page_url"] == null ? null : json["first_page_url"],
    from: json["from"] == null ? null : json["from"],
    lastPage: json["last_page"] == null ? null : json["last_page"],
    lastPageUrl: json["last_page_url"] == null ? null : json["last_page_url"],
    links: json["links"] == null ? null : List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"] == null ? null : json["path"],
    perPage: json["per_page"] == null ? null : json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"] == null ? null : json["to"],
    total: json["total"] == null ? null : json["total"],
  );

  Map<String?, dynamic> toJson() => {
    "current_page": currentPage == null ? null : currentPage,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl == null ? null : firstPageUrl,
    "from": from == null ? null : from,
    "last_page": lastPage == null ? null : lastPage,
    "last_page_url": lastPageUrl == null ? null : lastPageUrl,
    "links": links == null ? null : List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path == null ? null : path,
    "per_page": perPage == null ? null : perPage,
    "prev_page_url": prevPageUrl,
    "to": to == null ? null : to,
    "total": total == null ? null : total,
  };
}

class VendorItem {
  VendorItem({
    required this.id,
    required this.categoryId,
    required this.image,
    required this.name,
    required this.email,
    required this.mobile,
    required this.aMobile,
    required this.address,
    required this.timeStart,
    required this.timeEnd,
    required this.closingDay,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.vendorCategory,
  });

  int? id;
  int? categoryId;
  String? image;
  String? name;
  String? email;
  String? mobile;
  dynamic aMobile;
  String? address;
  String? timeStart;
  String? timeEnd;
  String? closingDay;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  VendorCategory? vendorCategory;

  factory VendorItem.fromJson(Map<String?, dynamic> json) => VendorItem(
    id: json["id"] == null ? null : json["id"],
    categoryId: json["category_id"] == null ? null : json["category_id"],
    image: json["image"] == null ? null : json["image"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    mobile: json["mobile"] == null ? null : json["mobile"],
    aMobile: json["a_mobile"],
    address: json["address"] == null ? null : json["address"],
    timeStart: json["time_start"] == null ? null : json["time_start"],
    timeEnd: json["time_end"] == null ? null : json["time_end"],
    closingDay: json["closing_day"] == null ? null : json["closing_day"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    vendorCategory: json["vendor_category"] == null ? null : VendorCategory.fromJson(json["vendor_category"]),
  );

  Map<String?, dynamic> toJson() => {
    "id": id == null ? null : id,
    "category_id": categoryId == null ? null : categoryId,
    "image": image == null ? null : image,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "mobile": mobile == null ? null : mobile,
    "a_mobile": aMobile,
    "address": address == null ? null : address,
    "time_start": timeStart == null ? null : timeStart,
    "time_end": timeEnd == null ? null : timeEnd,
    "closing_day": closingDay == null ? null : closingDay,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
    "vendor_category": vendorCategory == null ? null : vendorCategory!.toJson(),
  };
}

class VendorCategory {
  VendorCategory({
    required this.id,
    required this.vendorId,
    required this.categoryId,
    required this.subCategoryId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.subCategory,
  });

  int? id;
  int? vendorId;
  int? categoryId;
  int? subCategoryId;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  List<SubCategory>? subCategory;

  factory VendorCategory.fromJson(Map<String?, dynamic> json) => VendorCategory(
    id: json["id"] == null ? null : json["id"],
    vendorId: json["vendor_id"] == null ? null : json["vendor_id"],
    categoryId: json["category_id"] == null ? null : json["category_id"],
    subCategoryId: json["sub_category_id"] == null ? null : json["sub_category_id"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    subCategory: json["sub_category"] == null ? null : List<SubCategory>.from(json["sub_category"].map((x) => SubCategory.fromJson(x))),
  );

  Map<String?, dynamic> toJson() => {
    "id": id == null ? null : id,
    "vendor_id": vendorId == null ? null : vendorId,
    "category_id": categoryId == null ? null : categoryId,
    "sub_category_id": subCategoryId == null ? null : subCategoryId,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
    "sub_category": subCategory == null ? null : List<dynamic>.from(subCategory!.map((x) => x.toJson())),
  };
}

class SubCategory {
  SubCategory({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  int? id;
  int? userId;
  int? categoryId;
  String? name;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory SubCategory.fromJson(Map<String?, dynamic> json) => SubCategory(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    categoryId: json["category_id"] == null ? null : json["category_id"],
    name: json["name"] == null ? null : json["name"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String?, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "category_id": categoryId == null ? null : categoryId,
    "name": name == null ? null : name,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
  };
}

class Link {
  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory Link.fromJson(Map<String?, dynamic> json) => Link(
    url: json["url"] == null ? null : json["url"],
    label: json["label"] == null ? null : json["label"],
    active: json["active"] == null ? null : json["active"],
  );

  Map<String?, dynamic> toJson() => {
    "url": url == null ? null : url,
    "label": label == null ? null : label,
    "active": active == null ? null : active,
  };
}
