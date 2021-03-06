///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class GroupInviteAddResponseData {
/*
{
  "group-join": "group invite successfully"
}
*/

  String? groupJoin;

  GroupInviteAddResponseData({
    this.groupJoin,
  });
  GroupInviteAddResponseData.fromJson(Map<String, dynamic> json) {
    groupJoin = json["group-join"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["group-join"] = groupJoin;
    return data;
  }
}

class GroupInviteAddResponse {
/*
{
  "success": true,
  "data": {
    "group-join": "group invite successfully"
  },
  "message": "group invite successfully."
}
*/

  bool? success;
  GroupInviteAddResponseData? data;
  String? message;

  GroupInviteAddResponse({
    this.success,
    this.data,
    this.message,
  });
  GroupInviteAddResponse.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    data = (json["data"] != null) ? GroupInviteAddResponseData.fromJson(json["data"]) : null;
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
