///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class FriendBlockAddResponseData {
/*
{
  "post": "successfully"
}
*/

  String? post;

  FriendBlockAddResponseData({
    this.post,
  });
  FriendBlockAddResponseData.fromJson(Map<String, dynamic> json) {
    post = json["post"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["post"] = post;
    return data;
  }
}

class FriendBlockAddResponse {
/*
{
  "success": true,
  "data": {
    "post": "successfully"
  },
  "message": "block successfully."
}
*/

  bool? success;
  FriendBlockAddResponseData? data;
  String? message;

  FriendBlockAddResponse({
    this.success,
    this.data,
    this.message,
  });
  FriendBlockAddResponse.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    data = (json["data"] != null) ? FriendBlockAddResponseData.fromJson(json["data"]) : null;
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
