import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vanam_social/constants.dart';
import 'package:vanam_social/data/local/shared_pref.dart';
import 'package:vanam_social/screens/components/vanam_button.dart';
import 'package:vanam_social/screens/dark_mode/dark_mode_screen.dart';
import 'package:vanam_social/screens/group/welcome/group_welcome_screen.dart';
import 'package:vanam_social/screens/login/login_screen.dart';
import 'package:vanam_social/screens/profile/profile_screen.dart';
import 'package:vanam_social/screens/saved/saved_screen.dart';
import 'package:vanam_social/screens/setting/setting_screen.dart';
import 'package:vanam_social/screens/vendor/permission_location_view.dart';
import 'package:vanam_social/screens/vendor/vendor_list/vendor_zone_screen.dart';

class DrawerItem {
  final String icon;
  final String title;
  final Function onClick;

  DrawerItem(this.icon, this.title, this.onClick);
}

class DrawerView extends StatefulWidget {
  @override
  _DrawerViewState createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  String name = "";
  String userImage = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetails();
  }

  getUserDetails()async{
    name = await getUserName();
    userImage = await getUserImage();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: Color(0xff000000).withOpacity(0.1),
                blurRadius: 2,
                spreadRadius: 7,
                offset: Offset(0.3, -0.7))
          ]),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {},
                icon: SvgPicture.asset("assets/images/ic_close.svg")),
            SizedBox(
              height: 8,
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  gradient: LinearGradient(
                      colors: [Color(0xffFFCC00), Color(0xffFFEC3B)],
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      stops: [0.0, 1.0],
                      tileMode: TileMode.repeated),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        "$ImageBaseUrl$userImage",
                      ),
                      radius: 24,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: Text(
                      "$name",
                      style: Theme.of(context).textTheme.headline6,
                    )),
                    IconButton(
                        onPressed: () {},
                        icon:
                            SvgPicture.asset("assets/images/ic_arrow_right.svg"))
                  ],
                ),
              ),
            ),
            // SizedBox(
            //   height: 32,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     drawerItem("ic_vendor_zone", "Vendor Zone", () {}),
            //     drawerItem("ic_setting", "Setting", () {}),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     drawerItem("ic_groups", "Groups", () {}),
            //     drawerItem("ic_dark_mode", "Dark Mode", () {}),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     drawerItem("ic_saved", "Saved", () {}),
            //     drawerItem("", "", () {}),
            //   ],
            // ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                shrinkWrap: true,
                childAspectRatio: 1.3,
                children: [
                  drawerItem("ic_vendor_zone", "Vendor Zone", () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VendorZoneScreen()));
                  }),
                  drawerItem("ic_setting", "Setting", () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingScreen()));
                  }),
                  drawerItem("ic_groups", "Groups", () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GroupWelcomeScreen()));
                  }),
                  drawerItem("ic_dark_mode", "Dark Mode", () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DarkModeScreen()));
                  }),
                  // drawerItem("ic_saved", "Saved", () {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => SavedScreen()));
                  // }),
                ],
              ),
            ),
            PrimaryButton(text: "Logout", press: ()async {
              await saveLogin(false);
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
            }),
            SizedBox(
              height: 32,
            )
          ],
        ),
      ),
    );
  }

  Widget drawerItem(String icon, String title, Function() onClick) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: (MediaQuery.of(context).size.width / 2) * 0.6,
        height: 90,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          children: [
            Positioned(
              top: 25,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(8, 32, 8, 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Color(0xffFFCC00), width: 2)),
                child: Text(
                  "$title",
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                width: 42,
                height: 42,
                child: Stack(
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        "assets/images/ic_chat_circle_button_bg.svg",
                        width: 42,
                        height: 42,
                      ),
                    ),
                    Center(
                      child: SvgPicture.asset(
                        "assets/images/$icon.svg",
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
