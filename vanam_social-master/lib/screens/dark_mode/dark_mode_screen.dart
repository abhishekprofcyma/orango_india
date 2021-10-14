import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vanam_social/screens/dark_mode/welcome/theme_controller.dart';
import 'package:vanam_social/screens/home/components/drawer_view.dart';
import 'package:vanam_social/screens/home/components/vanam_app_bar_view.dart';

class DarkModeScreen extends StatefulWidget {
  @override
  _DarkModeScreenState createState() => _DarkModeScreenState();
}

class _DarkModeScreenState extends State<DarkModeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  bool isDarkModeEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
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
                "Dark mode",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            SwitchListTile(
              title: Text("Enable dark Mode"),
              value: isDarkModeEnabled,
              onChanged: (value){
                Provider.of<MyThemeModel>(context, listen: false).changeTheme();
              },

            )

          ],
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