import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

class SettingPrivacyScreen extends StatefulWidget {
  @override
  _SettingPrivacyScreenState createState() => _SettingPrivacyScreenState();
}

class _SettingPrivacyScreenState extends State<SettingPrivacyScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kPrimaryColor),
        leading: IconButton(
          icon: SvgPicture.asset("assets/images/ic_back_arrow_green.svg"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Privacy",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            settingItemView("ic_setting_privacy", "Privacy account", () {
            }),


          ],
        ),
      ),
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
            Text("$title")
          ],
        ),
      ),
    );
  }
}
