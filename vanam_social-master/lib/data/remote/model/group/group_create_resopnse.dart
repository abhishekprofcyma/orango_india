///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class GroupCreateResponseData {
/*
{
  "group": "group created successfully"
}
*/

  String? group;

  GroupCreateResponseData({
    this.group,
  });
  GroupCreateResponseData.fromJson(Map<String, dynamic> json) {
    group = json["group"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["group"] = group;
    return data;
  }
}

class GroupCreateResponse {
/*
{
  "success": true,
  "data": {
    "group": "group created successfully"
  },
  "message": " successfully."
}
*/

  bool? success;
  GroupCreateResponseData? data;
  String? message;

  GroupCreateResponse({
    this.success,
    this.data,
    this.message,
  });
  GroupCreateResponse.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    data = (json["data"] != null) ? GroupCreateResponseData.fromJson(json["data"]) : null;
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
