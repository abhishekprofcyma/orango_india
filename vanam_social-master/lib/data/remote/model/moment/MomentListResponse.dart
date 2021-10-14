// To parse this JSON data, do
//
//     final momentListResponse = momentListResponseFromJson(jsonString?);

import 'package:meta/meta.dart';
import 'dart:convert';

MomentListResponse momentListResponseFromJson(String? str) => MomentListResponse.fromJson(json.decode(str!));

String? momentListResponseToJson(MomentListResponse data) => json.encode(data.toJson());

class MomentListResponse {
  MomentListResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory MomentListResponse.fromJson(Map<String?, dynamic> json) => MomentListResponse(
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
    required this.momentList,
    required this.myMomentList,
  });

  MomentList? momentList;
  List<MomentItem>? myMomentList;

  factory Data.fromJson(Map<String?, dynamic> json) => Data(
    momentList: json["moment_list"] == null ? null : MomentList.fromJson(json["moment_list"]),
    myMomentList: json["my_moment_list"] == null ? null : List<MomentItem>.from(json["my_moment_list"].map((x) => MomentItem.fromJson(x))),
  );

  Map<String?, dynamic> toJson() => {
    "moment_list": momentList == null ? null : momentList!.toJson(),
    "my_moment_list": myMomentList == null ? null : List<dynamic>.from(myMomentList!.map((x) => x.toJson())),
  };
}

class MomentList {
  MomentList({
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
  List<MomentItem>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic? nextPageUrl;
  String? path;
  int? perPage;
  dynamic? prevPageUrl;
  int? to;
  int? total;

  factory MomentList.fromJson(Map<String?, dynamic> json) => MomentList(
    currentPage: json["current_page"] == null ? null : json["current_page"],
    data: json["data"] == null ? null : List<MomentItem>.from(json["data"].map((x) => MomentItem.fromJson(x))),
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

class MomentItem {
  MomentItem({
    required this.id,
    required this.userId,
    required this.url,
    required this.status,
    required this.createdAt,
    required this.deletedAt,
    required this.friend,
    required this.user,
  });

  int? id;
  int? userId;
  String? url;
  bool? status;
  DateTime? createdAt;
  dynamic deletedAt;
  Friend? friend;
  User? user;

  factory MomentItem.fromJson(Map<String?, dynamic> json) => MomentItem(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    url: json["url"] == null ? null : json["url"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    deletedAt: json["deleted_at"],
    friend: json["friend"] == null ? null : Friend.fromJson(json["friend"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String?, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "url": url == null ? null : url,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "deleted_at": deletedAt,
    "friend": friend == null ? null : friend!.toJson(),
    "user": user == null ? null : user!.toJson(),
  };
}

class Friend {
  Friend({
    required this.id,
    required this.friendBy,
    required this.friendTo,
    required this.status,
    required this.createdAt,
    required this.deletedAt,
    required this.user,
  });

  int? id;
  int? friendBy;
  int? friendTo;
  bool? status;
  DateTime? createdAt;
  dynamic? deletedAt;
  User? user;

  factory Friend.fromJson(Map<String?, dynamic> json) => Friend(
    id: json["id"] == null ? null : json["id"],
    friendBy: json["friend_by"] == null ? null : json["friend_by"],
    friendTo: json["friend_to"] == null ? null : json["friend_to"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    deletedAt: json["deleted_at"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String?, dynamic> toJson() => {
    "id": id == null ? null : id,
    "friend_by": friendBy == null ? null : friendBy,
    "friend_to": friendTo == null ? null : friendTo,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "deleted_at": deletedAt,
    "user": user == null ? null : user!.toJson(),
  };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.mobileNumber,
    required this.image,
  });

  int? id;
  String? name;
  String? email;
  String? mobileNumber;
  String? image;

  factory User.fromJson(Map<String?, dynamic> json) => User(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    mobileNumber: json["mobile_number"] == null ? null : json["mobile_number"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String?, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "mobile_number": mobileNumber == null ? null : mobileNumber,
    "image": image == null ? null : image,
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
