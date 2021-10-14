import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vanam_social/screens/home/components/drawer_view.dart';
import 'package:vanam_social/screens/home/components/vanam_app_bar_view.dart';
import 'package:vanam_social/screens/setting/blocked_account/blocked_accounts_screen.dart';
import 'package:vanam_social/screens/setting/connections/setting_connection_screen.dart';
import 'package:vanam_social/screens/setting/feeds_liked/feeds_liked_screen.dart';
import 'package:vanam_social/screens/setting/login_activity/login_activity_screen.dart';
import 'package:vanam_social/screens/setting/password_change/change_password_screen.dart';
import 'package:vanam_social/screens/setting/personal_information/personal_information_screen.dart';
import 'package:vanam_social/screens/setting/privacy/setting_privacy_screen.dart';
import 'package:vanam_social/screens/setting/search_history/search_history_screen.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VanamAppBarView(
                onMenuTap: () {
                  _key.currentState!.openDrawer();
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Settings",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              settingTitle("Account Privacy"),
              settingItemView("ic_setting_privacy", "Privacy", () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingPrivacyScreen()));
              }),

              settingTitle("Connections"),
              settingItemView("ic_setting_blocked_account", "Blocked Accounts", () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BlockedAccountScreen()));
              }),
              settingItemView("ic_setting_connections", "Your Connections", () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingConnectionScreen()));
              }),

              settingTitle("Security"),
              settingItemView("ic_setting_password", "Password", () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePasswordScreen()));
              }),
              settingItemView("ic_setting_login_activity", "Login Activity", () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginActivityScreen()));
              }),
              settingItemView("ic_setting_search_history", "Search history", () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchHistoryScreen()));
              }),

              settingTitle("Account"),
              settingItemView("ic_setting_personal_information", "Personal Information", () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PersonalInformationScreen()));
              }),
              settingItemView("ic_setting_feeds_you_liked", "Feeds you've liked", () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FeedsLikedScreen()));
              }),
            ],
          ),
        ),
      ),
      drawer: DrawerView(),
    );
  }

  Widget settingTitle(String title) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.subtitle2,
      ),
    );
  }

  Widget settingItemView(String icon, String title, Function() onClick) {
    return InkWell(
      onTap: onClick,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Color(0xffEFEFEF),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0.3,1.6)
            )
          ],
          borderRadius: BorderRadius.circular(6)
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              child: Stack(
                children: [
                  SvgPicture.asset("assets/images/ic_chat_circle_button_bg.svg"),
                  Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        "assets/images/$icon.svg",
                        color: Colors.black,
                        width: 14,
                      )),
                ],
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text("$title",style: Theme.of(context).textTheme.subtitle1,)
          ],
        ),
      ),
    );
  }
}
