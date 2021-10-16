///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class GroupInviteAccceptListResponseDataGroupInviteLinks {
/*
{
  "url": null,
  "label": "&laquo; Previous",
  "active": false
}
*/

  String? url;
  String? label;
  bool? active;

  GroupInviteAccceptListResponseDataGroupInviteLinks({
    this.url,
    this.label,
    this.active,
  });
  GroupInviteAccceptListResponseDataGroupInviteLinks.fromJson(Map<String, dynamic> json) {
    url = json["url"]?.toString();
    label = json["label"]?.toString();
    active = json["active"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["url"] = url;
    data["label"] = label;
    data["active"] = active;
    return data;
  }
}

class GroupInviteAccceptListResponseDataGroupInviteDataUser {
/*
{
  "id": 7,
  "name": "test9",
  "email": "test9@test.com",
  "mobile_number": "9999999999",
  "image": null
}
*/

  int? id;
  String? name;
  String? email;
  String? mobileNumber;
  String? image;

  GroupInviteAccceptListResponseDataGroupInviteDataUser({
    this.id,
    this.name,
    this.email,
    this.mobileNumber,
    this.image,
  });
  GroupInviteAccceptListResponseDataGroupInviteDataUser.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    name = json["name"]?.toString();
    email = json["email"]?.toString();
    mobileNumber = json["mobile_number"]?.toString();
    image = json["image"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["name"] = name;
    data["email"] = email;
    data["mobile_number"] = mobileNumber;
    data["image"] = image;
    return data;
  }
}

class GroupInviteAccceptListResponseDataGroupInviteDataGroup {
/*
{
  "id": 14,
  "createted_by": 7,
  "share_id": 3,
  "name": "Laptop space",
  "url": "group/logo/IMG_1626964093737.jpg",
  "status": true,
  "created_at": "2021-09-24T09:43:25.000000Z",
  "updated_at": "2021-09-24T09:43:25.000000Z",
  "deleted_at": null
}
*/

  int? id;
  int? createtedBy;
  int? shareId;
  String? name;
  String? url;
  bool? status;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  GroupInviteAccceptListResponseDataGroupInviteDataGroup({
    this.id,
    this.createtedBy,
    this.shareId,
    this.name,
    this.url,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
  GroupInviteAccceptListResponseDataGroupInviteDataGroup.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    createtedBy = json["createted_by"]?.toInt();
    shareId = json["share_id"]?.toInt();
    name = json["name"]?.toString();
    url = json["url"]?.toString();
    status = json["status"];
    createdAt = json["created_at"]?.toString();
    updatedAt = json["updated_at"]?.toString();
    deletedAt = json["deleted_at"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["createted_by"] = createtedBy;
    data["share_id"] = shareId;
    data["name"] = name;
    data["url"] = url;
    data["status"] = status;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["deleted_at"] = deletedAt;
    return data;
  }
}

class GroupInviteAccceptListResponseDataGroupInviteData {
/*
{
  "id": 11,
  "invited_by": 7,
  "user_id": 6,
  "group_id": 14,
  "status": true,
  "created_at": "2021-09-24T12:36:58.000000Z",
  "updated_at": "2021-09-24T12:36:58.000000Z",
  "deleted_at": null,
  "group": {
    "id": 14,
    "createted_by": 7,
    "share_id": 3,
    "name": "Laptop space",
    "url": "group/logo/IMG_1626964093737.jpg",
    "status": true,
    "created_at": "2021-09-24T09:43:25.000000Z",
    "updated_at": "2021-09-24T09:43:25.000000Z",
    "deleted_at": null
  },
  "user": {
    "id": 7,
    "name": "test9",
    "email": "test9@test.com",
    "mobile_number": "9999999999",
    "image": null
  }
}
*/

  int? id;
  int? invitedBy;
  int? userId;
  int? groupId;
  bool? status;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  GroupInviteAccceptListResponseDataGroupInviteDataGroup? group;
  GroupInviteAccceptListResponseDataGroupInviteDataUser? user;

  GroupInviteAccceptListResponseDataGroupInviteData({
    this.id,
    this.invitedBy,
    this.userId,
    this.groupId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.group,
    this.user,
  });
  GroupInviteAccceptListResponseDataGroupInviteData.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    invitedBy = json["invited_by"]?.toInt();
    userId = json["user_id"]?.toInt();
    groupId = json["group_id"]?.toInt();
    status = json["status"];
    createdAt = json["created_at"]?.toString();
    updatedAt = json["updated_at"]?.toString();
    deletedAt = json["deleted_at"]?.toString();
    group = (json["group"] != null) ? GroupInviteAccceptListResponseDataGroupInviteDataGroup.fromJson(json["group"]) : null;
    user = (json["user"] != null) ? GroupInviteAccceptListResponseDataGroupInviteDataUser.fromJson(json["user"]) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["invited_by"] = invitedBy;
    data["user_id"] = userId;
    data["group_id"] = groupId;
    data["status"] = status;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["deleted_at"] = deletedAt;
    if (group != null) {
      data["group"] = group!.toJson();
    }
    if (user != null) {
      data["user"] = user!.toJson();
    }
    return data;
  }
}

class GroupInviteAccceptListResponseDataGroupInvite {
/*
{
  "current_page": 1,
  "data": [
    {
      "id": 11,
      "invited_by": 7,
      "user_id": 6,
      "group_id": 14,
      "status": true,
      "created_at": "2021-09-24T12:36:58.000000Z",
      "updated_at": "2021-09-24T12:36:58.000000Z",
      "deleted_at": null,
      "group": {
        "id": 14,
        "createted_by": 7,
        "share_id": 3,
        "name": "Laptop space",
        "url": "group/logo/IMG_1626964093737.jpg",
        "status": true,
        "created_at": "2021-09-24T09:43:25.000000Z",
        "updated_at": "2021-09-24T09:43:25.000000Z",
        "deleted_at": null
      },
      "user": {
        "id": 7,
        "name": "test9",
        "email": "test9@test.com",
        "mobile_number": "9999999999",
        "image": null
      }
    }
  ],
  "first_page_url": "http://192.168.10.8/prof_vanam/public/api/invite-list?page=1",
  "from": 1,
  "last_page": 1,
  "last_page_url": "http://192.168.10.8/prof_vanam/public/api/invite-list?page=1",
  "links": [
    {
      "url": null,
      "label": "&laquo; Previous",
      "active": false
    }
  ],
  "next_page_url": null,
  "path": "http://192.168.10.8/prof_vanam/public/api/invite-list",
  "per_page": 10,
  "prev_page_url": null,
  "to": 1,
  "total": 1
}
*/

  int? currentPage;
  List<GroupInviteAccceptListResponseDataGroupInviteData?>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<GroupInviteAccceptListResponseDataGroupInviteLinks?>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  GroupInviteAccceptListResponseDataGroupInvite({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });
  GroupInviteAccceptListResponseDataGroupInvite.fromJson(Map<String, dynamic> json) {
    currentPage = json["current_page"]?.toInt();
    if (json["data"] != null) {
      final v = json["data"];
      final arr0 = <GroupInviteAccceptListResponseDataGroupInviteData>[];
      v.forEach((v) {
        arr0.add(GroupInviteAccceptListResponseDataGroupInviteData.fromJson(v));
      });
      this.data = arr0;
    }
    firstPageUrl = json["first_page_url"]?.toString();
    from = json["from"]?.toInt();
    lastPage = json["last_page"]?.toInt();
    lastPageUrl = json["last_page_url"]?.toString();
    if (json["links"] != null) {
      final v = json["links"];
      final arr0 = <GroupInviteAccceptListResponseDataGroupInviteLinks>[];
      v.forEach((v) {
        arr0.add(GroupInviteAccceptListResponseDataGroupInviteLinks.fromJson(v));
      });
      links = arr0;
    }
    nextPageUrl = json["next_page_url"]?.toString();
    path = json["path"]?.toString();
    perPage = json["per_page"]?.toInt();
    prevPageUrl = json["prev_page_url"]?.toString();
    to = json["to"]?.toInt();
    total = json["total"]?.toInt();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["current_page"] = currentPage;
    if (this.data != null) {
      final v = this.data;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data["data"] = arr0;
    }
    data["first_page_url"] = firstPageUrl;
    data["from"] = from;
    data["last_page"] = lastPage;
    data["last_page_url"] = lastPageUrl;
    if (links != null) {
      final v = links;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data["links"] = arr0;
    }
    data["next_page_url"] = nextPageUrl;
    data["path"] = path;
    data["per_page"] = perPage;
    data["prev_page_url"] = prevPageUrl;
    data["to"] = to;
    data["total"] = total;
    return data;
  }
}

class GroupInviteAccceptListResponseData {
/*
{
  "group-invite": {
    "current_page": 1,
    "data": [
      {
        "id": 11,
        "invited_by": 7,
        "user_id": 6,
        "group_id": 14,
        "status": true,
        "created_at": "2021-09-24T12:36:58.000000Z",
        "updated_at": "2021-09-24T12:36:58.000000Z",
        "deleted_at": null,
        "group": {
          "id": 14,
          "createted_by": 7,
          "share_id": 3,
          "name": "Laptop space",
          "url": "group/logo/IMG_1626964093737.jpg",
          "status": true,
          "created_at": "2021-09-24T09:43:25.000000Z",
          "updated_at": "2021-09-24T09:43:25.000000Z",
          "deleted_at": null
        },
        "user": {
          "id": 7,
          "name": "test9",
          "email": "test9@test.com",
          "mobile_number": "9999999999",
          "image": null
        }
      }
    ],
    "first_page_url": "http://192.168.10.8/prof_vanam/public/api/invite-list?page=1",
    "from": 1,
    "last_page": 1,
    "last_page_url": "http://192.168.10.8/prof_vanam/public/api/invite-list?page=1",
    "links": [
      {
        "url": null,
        "label": "&laquo; Previous",
        "active": false
      }
    ],
    "next_page_url": null,
    "path": "http://192.168.10.8/prof_vanam/public/api/invite-list",
    "per_page": 10,
    "prev_page_url": null,
    "to": 1,
    "total": 1
  }
}
*/

  GroupInviteAccceptListResponseDataGroupInvite? groupInvite;

  GroupInviteAccceptListResponseData({
    this.groupInvite,
  });
  GroupInviteAccceptListResponseData.fromJson(Map<String, dynamic> json) {
    groupInvite = (json["group-invite"] != null) ? GroupInviteAccceptListResponseDataGroupInvite.fromJson(json["group-invite"]) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (groupInvite != null) {
      data["group-invite"] = groupInvite!.toJson();
    }
    return data;
  }
}

class GroupInviteAccceptListResponse {
/*
{
  "success": true,
  "data": {
    "group-invite": {
      "current_page": 1,
      "data": [
        {
          "id": 11,
          "invited_by": 7,
          "user_id": 6,
          "group_id": 14,
          "status": true,
          "created_at": "2021-09-24T12:36:58.000000Z",
          "updated_at": "2021-09-24T12:36:58.000000Z",
          "deleted_at": null,
          "group": {
            "id": 14,
            "createted_by": 7,
            "share_id": 3,
            "name": "Laptop space",
            "url": "group/logo/IMG_1626964093737.jpg",
            "status": true,
            "created_at": "2021-09-24T09:43:25.000000Z",
            "updated_at": "2021-09-24T09:43:25.000000Z",
            "deleted_at": null
          },
          "user": {
            "id": 7,
            "name": "test9",
            "email": "test9@test.com",
            "mobile_number": "9999999999",
            "image": null
          }
        }
      ],
      "first_page_url": "http://192.168.10.8/prof_vanam/public/api/invite-list?page=1",
      "from": 1,
      "last_page": 1,
      "last_page_url": "http://192.168.10.8/prof_vanam/public/api/invite-list?page=1",
      "links": [
        {
          "url": null,
          "label": "&laquo; Previous",
          "active": false
        }
      ],
      "next_page_url": null,
      "path": "http://192.168.10.8/prof_vanam/public/api/invite-list",
      "per_page": 10,
      "prev_page_url": null,
      "to": 1,
      "total": 1
    }
  },
  "message": "Group   list."
}
*/

  bool? success;
  GroupInviteAccceptListResponseData? data;
  String? message;

  GroupInviteAccceptListResponse({
    this.success,
    this.data,
    this.message,
  });
  GroupInviteAccceptListResponse.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    data = (json["data"] != null) ? GroupInviteAccceptListResponseData.fromJson(json["data"]) : null;
    message = json["message"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["success"] = success;
    if (data != null) {
      data["data"] = this.data!.toJson();
    }
    data["message"] = message;
    return data;
  }
}