// To parse this JSON data, do
//
//     final vendorPlanListResponse = vendorPlanListResponseFromJson(jsonString?);

import 'dart:convert';

VendorPlanListResponse vendorPlanListResponseFromJson(String? str) => VendorPlanListResponse.fromJson(json.decode(str??""));

String? vendorPlanListResponseToJson(VendorPlanListResponse data) => json.encode(data.toJson());

class VendorPlanListResponse {
  VendorPlanListResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory VendorPlanListResponse.fromJson(Map<String?, dynamic> json) => VendorPlanListResponse(
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
    required this.vendor,
  });

  Vendor? vendor;

  factory Data.fromJson(Map<String?, dynamic> json) => Data(
    vendor: Vendor.fromJson(json["vendor"]),
  );

  Map<String?, dynamic> toJson() => {
    "vendor": vendor!.toJson(),
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
  List<Datum>? data;
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
    currentPage: json["current_page"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String?, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Datum {
  Datum({
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
    required this.vendorSubscription,
  });

  int? id;
  int? categoryId;
  String? image;
  String? name;
  String? email;
  String? mobile;
  String? aMobile;
  String? address;
  String? timeStart;
  String? timeEnd;
  String? closingDay;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  List<VendorSubscription>? vendorSubscription;

  factory Datum.fromJson(Map<String?, dynamic> json) => Datum(
    id: json["id"],
    categoryId: json["category_id"],
    image: json["image"],
    name: json["name"],
    email: json["email"],
    mobile: json["mobile"],
    aMobile: json["a_mobile"],
    address: json["address"],
    timeStart: json["time_start"],
    timeEnd: json["time_end"],
    closingDay: json["closing_day"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    vendorSubscription: List<VendorSubscription>.from(json["vendor_subscription"].map((x) => VendorSubscription.fromJson(x))),
  );

  Map<String?, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "image": image,
    "name": name,
    "email": email,
    "mobile": mobile,
    "a_mobile": aMobile,
    "address": address,
    "time_start": timeStart,
    "time_end": timeEnd,
    "closing_day": closingDay,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
    "vendor_subscription": List<dynamic>.from(vendorSubscription!.map((x) => x.toJson())),
  };
}

class VendorSubscription {
  VendorSubscription({
    required this.id,
    required this.vendorId,
    required this.planId,
    required this.price,
    required this.features,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.plan,
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
  Plan? plan;

  factory VendorSubscription.fromJson(Map<String?, dynamic> json) => VendorSubscription(
    id: json["id"],
    vendorId: json["vendor_id"],
    planId: json["plan_id"],
    price: json["price"],
    features: json["features"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    plan: Plan.fromJson(json["plan"]),
  );

  Map<String?, dynamic> toJson() => {
    "id": id,
    "vendor_id": vendorId,
    "plan_id": planId,
    "price": price,
    "features": features,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
    "plan": plan!.toJson(),
  };
}

class Plan {
  Plan({
    required this.id,
    required this.name,
  });

  int? id;
  String? name;

  factory Plan.fromJson(Map<String?, dynamic> json) => Plan(
    id: json["id"],
    name: json["name"],
  );

  Map<String?, dynamic> toJson() => {
    "id": id,
    "name": name,
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
    label: json["label"],
    active: json["active"],
  );

  Map<String?, dynamic> toJson() => {
    "url": url == null ? null : url,
    "label": label,
    "active": active,
  };
}
