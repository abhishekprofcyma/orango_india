///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class UnFriendResponseData {
/*
{
  "post": "successfully"
}
*/

  String? post;

  UnFriendResponseData({
    this.post,
  });
  UnFriendResponseData.fromJson(Map<String, dynamic> json) {
    post = json["post"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["post"] = post;
    return data;
  }
}

class UnFriendResponse {
/*
{
  "success": true,
  "data": {
    "post": "successfully"
  },
  "message": "Delete successfully."
}
*/

  bool? success;
  UnFriendResponseData? data;
  String? message;

  UnFriendResponse({
    this.success,
    this.data,
    this.message,
  });
  UnFriendResponse.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    data = (json["data"] != null) ? UnFriendResponseData.fromJson(json["data"]) : null;
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
