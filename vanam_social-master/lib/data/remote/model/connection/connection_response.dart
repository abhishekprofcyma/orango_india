///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class ConnectionResponseDataUserListLinks {
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

  ConnectionResponseDataUserListLinks({
    this.url,
    this.label,
    this.active,
  });
  ConnectionResponseDataUserListLinks.fromJson(Map<String, dynamic> json) {
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

class ConnectionResponseDataUserListData {
/*
{
  "id": 24,
  "image": null,
  "name": "guddu",
  "email": "guddukmr1@gmail.com",
  "gender": "Male",
  "mobile_number": "6200019516",
  "email_verified_at": null,
  "type": "customer",
  "status": true,
  "created_at": "2021-07-28T05:32:06.000000Z",
  "updated_at": "2021-08-21T12:40:59.000000Z",
  "deleted_at": null,
  "device_key": "czlQN5awSiCXpA9eGa6AWb:APA91bGxn6l-2vy9RAoL48neH387AnnGqSeA68R0x-vhhH6olm_w2J_MZQhTuV9HuZnqNUgBH8PODa2KAdxe5P8-3yaP7QNQhPZy-uYCcm8XIBkUx08gmZWjLh1uHLnzZCvCApWD5Svu",
  "device_token": null
}
*/

  int? id;
  String? image;
  String? name;
  String? email;
  String? gender;
  String? mobileNumber;
  String? emailVerifiedAt;
  String? type;
  bool? status;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? deviceKey;
  String? deviceToken;

  ConnectionResponseDataUserListData({
    this.id,
    this.image,
    this.name,
    this.email,
    this.gender,
    this.mobileNumber,
    this.emailVerifiedAt,
    this.type,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.deviceKey,
    this.deviceToken,
  });
  ConnectionResponseDataUserListData.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    image = json["image"]?.toString();
    name = json["name"]?.toString();
    email = json["email"]?.toString();
    gender = json["gender"]?.toString();
    mobileNumber = json["mobile_number"]?.toString();
    emailVerifiedAt = json["email_verified_at"]?.toString();
    type = json["type"]?.toString();
    status = json["status"];
    createdAt = json["created_at"]?.toString();
    updatedAt = json["updated_at"]?.toString();
    deletedAt = json["deleted_at"]?.toString();
    deviceKey = json["device_key"]?.toString();
    deviceToken = json["device_token"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["image"] = image;
    data["name"] = name;
    data["email"] = email;
    data["gender"] = gender;
    data["mobile_number"] = mobileNumber;
    data["email_verified_at"] = emailVerifiedAt;
    data["type"] = type;
    data["status"] = status;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["deleted_at"] = deletedAt;
    data["device_key"] = deviceKey;
    data["device_token"] = deviceToken;
    return data;
  }
}

class ConnectionResponseDataUserList {
/*
{
  "current_page": 1,
  "data": [
    {
      "id": 24,
      "image": null,
      "name": "guddu",
      "email": "guddukmr1@gmail.com",
      "gender": "Male",
      "mobile_number": "6200019516",
      "email_verified_at": null,
      "type": "customer",
      "status": true,
      "created_at": "2021-07-28T05:32:06.000000Z",
      "updated_at": "2021-08-21T12:40:59.000000Z",
      "deleted_at": null,
      "device_key": "czlQN5awSiCXpA9eGa6AWb:APA91bGxn6l-2vy9RAoL48neH387AnnGqSeA68R0x-vhhH6olm_w2J_MZQhTuV9HuZnqNUgBH8PODa2KAdxe5P8-3yaP7QNQhPZy-uYCcm8XIBkUx08gmZWjLh1uHLnzZCvCApWD5Svu",
      "device_token": null
    }
  ],
  "first_page_url": "http://192.168.10.35/prof_vanam/public/api/conection?page=1",
  "from": 1,
  "last_page": 1,
  "last_page_url": "http://192.168.10.35/prof_vanam/public/api/conection?page=1",
  "links": [
    {
      "url": null,
      "label": "&laquo; Previous",
      "active": false
    }
  ],
  "next_page_url": null,
  "path": "http://192.168.10.35/prof_vanam/public/api/conection",
  "per_page": 10,
  "prev_page_url": null,
  "to": 2,
  "total": 2
}
*/

  int? currentPage;
  List<ConnectionResponseDataUserListData?>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<ConnectionResponseDataUserListLinks?>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  ConnectionResponseDataUserList({
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
  ConnectionResponseDataUserList.fromJson(Map<String, dynamic> json) {
    currentPage = json["current_page"]?.toInt();
    if (json["data"] != null) {
      final v = json["data"];
      final arr0 = <ConnectionResponseDataUserListData>[];
      v.forEach((v) {
        arr0.add(ConnectionResponseDataUserListData.fromJson(v));
      });
      this.data = arr0;
    }
    firstPageUrl = json["first_page_url"]?.toString();
    from = json["from"]?.toInt();
    lastPage = json["last_page"]?.toInt();
    lastPageUrl = json["last_page_url"]?.toString();
    if (json["links"] != null) {
      final v = json["links"];
      final arr0 = <ConnectionResponseDataUserListLinks>[];
      v.forEach((v) {
        arr0.add(ConnectionResponseDataUserListLinks.fromJson(v));
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

class ConnectionResponseData {
/*
{
  "user_list": {
    "current_page": 1,
    "data": [
      {
        "id": 24,
        "image": null,
        "name": "guddu",
        "email": "guddukmr1@gmail.com",
        "gender": "Male",
        "mobile_number": "6200019516",
        "email_verified_at": null,
        "type": "customer",
        "status": true,
        "created_at": "2021-07-28T05:32:06.000000Z",
        "updated_at": "2021-08-21T12:40:59.000000Z",
        "deleted_at": null,
        "device_key": "czlQN5awSiCXpA9eGa6AWb:APA91bGxn6l-2vy9RAoL48neH387AnnGqSeA68R0x-vhhH6olm_w2J_MZQhTuV9HuZnqNUgBH8PODa2KAdxe5P8-3yaP7QNQhPZy-uYCcm8XIBkUx08gmZWjLh1uHLnzZCvCApWD5Svu",
        "device_token": null
      }
    ],
    "first_page_url": "http://192.168.10.35/prof_vanam/public/api/conection?page=1",
    "from": 1,
    "last_page": 1,
    "last_page_url": "http://192.168.10.35/prof_vanam/public/api/conection?page=1",
    "links": [
      {
        "url": null,
        "label": "&laquo; Previous",
        "active": false
      }
    ],
    "next_page_url": null,
    "path": "http://192.168.10.35/prof_vanam/public/api/conection",
    "per_page": 10,
    "prev_page_url": null,
    "to": 2,
    "total": 2
  }
}
*/

  ConnectionResponseDataUserList? userList;

  ConnectionResponseData({
    this.userList,
  });
  ConnectionResponseData.fromJson(Map<String, dynamic> json) {
    userList = (json["user_list"] != null) ? ConnectionResponseDataUserList.fromJson(json["user_list"]) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (userList != null) {
      data["user_list"] = userList!.toJson();
    }
    return data;
  }
}

class ConnectionResponse {
/*
{
  "success": true,
  "data": {
    "user_list": {
      "current_page": 1,
      "data": [
        {
          "id": 24,
          "image": null,
          "name": "guddu",
          "email": "guddukmr1@gmail.com",
          "gender": "Male",
          "mobile_number": "6200019516",
          "email_verified_at": null,
          "type": "customer",
          "status": true,
          "created_at": "2021-07-28T05:32:06.000000Z",
          "updated_at": "2021-08-21T12:40:59.000000Z",
          "deleted_at": null,
          "device_key": "czlQN5awSiCXpA9eGa6AWb:APA91bGxn6l-2vy9RAoL48neH387AnnGqSeA68R0x-vhhH6olm_w2J_MZQhTuV9HuZnqNUgBH8PODa2KAdxe5P8-3yaP7QNQhPZy-uYCcm8XIBkUx08gmZWjLh1uHLnzZCvCApWD5Svu",
          "device_token": null
        }
      ],
      "first_page_url": "http://192.168.10.35/prof_vanam/public/api/conection?page=1",
      "from": 1,
      "last_page": 1,
      "last_page_url": "http://192.168.10.35/prof_vanam/public/api/conection?page=1",
      "links": [
        {
          "url": null,
          "label": "&laquo; Previous",
          "active": false
        }
      ],
      "next_page_url": null,
      "path": "http://192.168.10.35/prof_vanam/public/api/conection",
      "per_page": 10,
      "prev_page_url": null,
      "to": 2,
      "total": 2
    }
  },
  "message": "Connection  list."
}
*/

  bool? success;
  ConnectionResponseData? data;
  String? message;

  ConnectionResponse({
    this.success,
    this.data,
    this.message,
  });
  ConnectionResponse.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    data = (json["data"] != null) ? ConnectionResponseData.fromJson(json["data"]) : null;
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