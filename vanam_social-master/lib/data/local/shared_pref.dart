import 'package:shared_preferences/shared_preferences.dart';


Future<bool?> getLogin() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getBool("login") != null
      ? preferences.getBool("login")
      : false;
}

Future<bool> saveLogin(bool isLogin) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setBool("login", isLogin);
}

Future<String> getToken() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString("token") ?? "";
}

Future<bool> saveToken(String token) async {
  print("token saved $token");
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setString("token", token);
}

Future<bool> getIntroShow() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getBool("intro_show") ?? true;
}

Future<bool> saveIntroShow(bool show) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setBool("intro_show", show);
}

Future<String> getUserName() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString("username") ?? "";
}

Future<bool> saveUserName(String name) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setString("username", name);
}

Future<String?> getUserId() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString("userid");
}

Future<bool> saveUserId(String email) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setString("userid", email);
}

Future<String> getMobile() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString("mobile") ?? "";
}

Future<bool> saveMobile(String name) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setString("mobile", name);
}

Future<String> getUserImage() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString("user_image") ?? "";
}

Future<bool> saveUserImage(String name) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setString("user_image", name);
}

Future<String> getTagLine() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString("tagline") ?? "";
}

Future<bool> saveTagLine(String name) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setString("tagline", name);
}

Future<List<String>> getPopularSearch() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getStringList("search") ?? [];
}

Future<bool> savePopularSearch(List<String> popularSearchList) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setStringList("search", popularSearchList);
}
