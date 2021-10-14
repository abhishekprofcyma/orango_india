// To parse this JSON data, do
//
//     final postCommentListResponse = postCommentListResponseFromJson(jsonString?);

import 'dart:convert';

PostCommentListResponse postCommentListResponseFromJson(String? str) => PostCommentListResponse.fromJson(json.decode(str!));

String? postCommentListResponseToJson(PostCommentListResponse data) => json.encode(data.toJson());

class PostCommentListResponse {
  PostCommentListResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory PostCommentListResponse.fromJson(Map<String?, dynamic> json) => PostCommentListResponse(
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
    required this.postList,
  });

  PostList? postList;

  factory Data.fromJson(Map<String?, dynamic> json) => Data(
    postList: PostList.fromJson(json["post_list"]),
  );

  Map<String?, dynamic> toJson() => {
    "post_list": postList!.toJson(),
  };
}

class PostList {
  PostList({
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
  List<CommentItem>? data;
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

  factory PostList.fromJson(Map<String?, dynamic> json) => PostList(
    currentPage: json["current_page"],
    data: List<CommentItem>.from(json["data"].map((x) => CommentItem.fromJson(x))),
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

class CommentItem {
  CommentItem({
    required this.id,
    required this.userId,
    required this.postId,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.user,
    required this.recomment,
    required this.postCommentId,
  });

  int? id;
  int? userId;
  int? postId;
  String? comment;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  User? user;
  List<CommentItem>? recomment;
  int? postCommentId;

  factory CommentItem.fromJson(Map<String?, dynamic> json) => CommentItem(
    id: json["id"],
    userId: json["user_id"],
    postId: json["post_id"],
    comment: json["comment"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    user: User.fromJson(json["user"]),
    recomment: json["recomment"] == null ? null : List<CommentItem>.from(json["recomment"].map((x) => CommentItem.fromJson(x))),
    postCommentId: json["post_comment_id"] == null ? null : json["post_comment_id"],
  );

  Map<String?, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "post_id": postId,
    "comment": comment,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
    "user": user!.toJson(),
    "recomment": recomment == null ? null : List<dynamic>.from(recomment!.map((x) => x.toJson())),
    "post_comment_id": postCommentId == null ? null : postCommentId,
  };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.mobileNumber,
  });

  int? id;
  String? name;
  String? email;
  String? mobileNumber;

  factory User.fromJson(Map<String?, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    mobileNumber: json["mobile_number"],
  );

  Map<String?, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "mobile_number": mobileNumber,
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
