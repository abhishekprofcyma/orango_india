///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class LoginFailResponse {
/*
{
  "success": false,
  "message": "Please Enter Correct Mobile and Email.",
  "data": "401"
}
*/

  bool? success;
  String? message;
  String? data;

  LoginFailResponse({
    this.success,
    this.message,
    this.data,
  });
  LoginFailResponse.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    message = json["message"]?.toString();
    data = json["data"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["success"] = success;
    data["message"] = message;
    data["data"] = this.data;
    return data;
  }
}
