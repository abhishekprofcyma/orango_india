import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vanam_social/data/cubit/chat/chat_cubit.dart';
import 'package:vanam_social/data/cubit/chat/chat_state.dart';
import 'package:vanam_social/data/cubit/connection/connection_cubit.dart';
import 'package:vanam_social/data/cubit/connection/connection_state.dart';
import 'package:vanam_social/data/cubit/friend/friend_cubit.dart';
import 'package:vanam_social/data/cubit/friend/friend_state.dart';
import 'package:vanam_social/data/cubit/gallery/gallery_cubit.dart';
import 'package:vanam_social/data/cubit/gallery/gallery_state.dart';
import 'package:vanam_social/data/cubit/group/group_cubit.dart';
import 'package:vanam_social/data/cubit/group/group_state.dart';
import 'package:vanam_social/data/cubit/login/login_cubit.dart';
import 'package:vanam_social/data/cubit/moment/moment_cubit.dart';
import 'package:vanam_social/data/cubit/moment/moment_state.dart';
import 'package:vanam_social/data/cubit/otp/otp_cubit.dart';
import 'package:vanam_social/data/cubit/otp/otp_state.dart';
import 'package:vanam_social/data/cubit/post_list/post_list_cubit.dart';
import 'package:vanam_social/data/cubit/post_list/post_list_state.dart';
import 'package:vanam_social/data/cubit/profile/profile_cubit.dart';
import 'package:vanam_social/data/cubit/profile/profile_state.dart';
import 'package:vanam_social/data/cubit/register/register_cubit.dart';
import 'package:vanam_social/data/cubit/register/register_state.dart';
import 'package:vanam_social/data/cubit/reset_password/reset_password_cubit.dart';
import 'package:vanam_social/data/cubit/reset_password/reset_password_state.dart';
import 'package:vanam_social/data/cubit/vendor/VenderCubit.dart';
import 'package:vanam_social/data/cubit/vendor/VendorState.dart';
import 'package:vanam_social/screens/dark_mode/welcome/theme_controller.dart';
import 'package:vanam_social/screens/intro/intro_screen.dart';
import 'package:vanam_social/screens/login/login_screen.dart';
import 'package:vanam_social/screens/profile/profile_screen.dart';
import 'package:vanam_social/screens/signup/signup_screen.dart';
import 'package:vanam_social/screens/splash/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:vanam_social/test_view.dart';

import 'data/cubit/login/login_state.dart';


FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

Future<void> _messageHandler(RemoteMessage message) async {
  print("notification received ${message.notification!.body}");
  displayNotification(message);
}

Future displayNotification(RemoteMessage message) async{
  var initializationSettingsAndroid = new AndroidInitializationSettings('@drawable/logo');
  //var initializationSettingsIOS = new IOSInitializationSettings(onDidReceiveLocalNotification: onDidRecieveLocalNotification() );
  var initializationSettings = new InitializationSettings(android: initializationSettingsAndroid);
  flutterLocalNotificationsPlugin.initialize(initializationSettings);
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'channelid', 'flutterfcm', 'your channel description',
      importance: Importance.max, priority: Priority.high);
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  var macPlatformChannelSpecifics = new MacOSNotificationDetails();
  var platformChannelSpecifics = new NotificationDetails(android: androidPlatformChannelSpecifics,iOS: iOSPlatformChannelSpecifics,macOS: macPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    message.notification!.title,
    message.notification!.body,
    platformChannelSpecifics,
    payload: 'hello',);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (isWebPlatform()) {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_messageHandler);
  }
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static GlobalKey mtAppKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyThemeModel(),
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Consumer<MyThemeModel>(
          builder: (context, theme, child) => MultiBlocProvider(
              providers: [
                BlocProvider<LoginCubit>(
                  lazy: true,
                  create: (context) => LoginCubit(LoginInitial()),
                ),
                BlocProvider<RegisterCubit>(
                  lazy: true,
                  create: (context) => RegisterCubit(RegisterInitial()),
                ),
                BlocProvider<OtpCubit>(
                  lazy: true,
                  create: (context) => OtpCubit(OtpInitial()),
                ),
                BlocProvider<ResetPasswordCubit>(
                  lazy: true,
                  create: (context) =>
                      ResetPasswordCubit(ResetPasswordInitial()),
                ),
                BlocProvider<PostListCubit>(
                  lazy: true,
                  create: (context) => PostListCubit(PostListInitial()),
                ),
                BlocProvider<ConnectionCubit>(
                  lazy: true,
                  create: (context) => ConnectionCubit(ConnectionInitial()),
                ),
                BlocProvider<FriendCubit>(
                  lazy: true,
                  create: (context) => FriendCubit(FriendInitial()),
                ),
                BlocProvider<ChatCubit>(
                  lazy: true,
                  create: (context) => ChatCubit(ChatInitial()),
                ),
                BlocProvider<ProfileCubit>(
                  lazy: true,
                  create: (context) => ProfileCubit(ProfileInitial()),
                ),
                BlocProvider<MomentCubit>(
                  lazy: true,
                  create: (context) => MomentCubit(MomentInitial()),
                ),
                BlocProvider<VendorCubit>(
                  lazy: true,
                  create: (context) => VendorCubit(VendorInitial()),
                ),
                BlocProvider<GalleryCubit>(
                  lazy: true,
                  create: (context) => GalleryCubit(GalleryInitial()),
                ),
                BlocProvider<GroupCubit>(
                  lazy: true,
                  create: (context) => GroupCubit(GroupInitial()),
                ),
              ],
              child: MaterialApp(
                key: MyApp.mtAppKey,
                title: 'Vanam Social',
                debugShowCheckedModeBanner: false,
                theme: themeData(context),
                darkTheme: darkThemeData(context),
                themeMode: theme.isLightTheme ? ThemeMode.light : ThemeMode.dark,
                //home: TestView(),
                initialRoute: '/',
                routes: {
                  '/': (context) => SplashScreen(),
                  '/intro': (context) => IntroScreen(
                        indexPage: 0,
                      ),
                  '/login': (context) => LoginScreen(),
                  '/signup': (context) => SignUpScreen(),
                },
              )),
        ),
      ),
    );
  }
}

DateTime stringToDateTime(String date) {
  //DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(date);
  DateTime tempDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(date);
  return tempDate;
}

DateTime stringToDateTime1(String date) {
  //DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(date);
  DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss.zzz").parse(date);
  return tempDate;
}

DateTime stringToDateTimeDefault(int date) {
  //DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(date);
  DateTime tempDate =  new DateTime.fromMicrosecondsSinceEpoch(date);
  return tempDate;
}

bool isWebPlatform() {
  bool kisweb = false;
  try {
    if (Platform.isAndroid || Platform.isIOS) {
      kisweb = false;
    } else {
      kisweb = true;
    }
  } catch (e) {
    kisweb = true;
  }
  return kisweb;
}

Future<String> getDeviceId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    // import 'dart:io'
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.androidId; // unique ID on Android
  }
}

Future<String> getDeviceName() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    // import 'dart:io'
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.systemName; // unique ID on iOS
  } else {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.device; // unique ID on Android
  }
}

Future<String> getDeviceModel() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    // import 'dart:io'
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.model; // unique ID on iOS
  } else {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.model; // unique ID on Android
  }
}

AlertDialog showLoaderDialog(BuildContext context){
  AlertDialog alert=AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
      ],),
  );
  showDialog(barrierDismissible: false,
    context:context,
    builder:(BuildContext context){
      return alert;
    },
  );
  return alert;
}
