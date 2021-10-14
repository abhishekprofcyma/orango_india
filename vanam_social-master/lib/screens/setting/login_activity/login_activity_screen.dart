import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vanam_social/data/local/shared_pref.dart';

import '../../../constants.dart';

class LoginActivityScreen extends StatefulWidget {
  @override
  _LoginActivityScreenState createState() => _LoginActivityScreenState();
}

class _LoginActivityScreenState extends State<LoginActivityScreen> {
  DatabaseReference? reference;
  String deviceId = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    init();
  }

  init() async {
    String userId = (await getUserId())!;
    deviceId = (await getUserId())!;
    reference =
        FirebaseDatabase.instance.reference().child("login").child(userId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Login activity",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "where you're logged in",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              if (reference != null)
                FirebaseAnimatedList(
                    query: reference!,
                    shrinkWrap: true,
                    padding: new EdgeInsets.all(8.0),
                    physics: AlwaysScrollableScrollPhysics(),
                    reverse: false,
                    itemBuilder: (_, DataSnapshot snapshot,
                        Animation<double> animation, int x) {
                      if (snapshot == null) {
                        return Text("No Data");
                      }
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              child: Stack(
                                children: [
                                  SvgPicture.asset(
                                      "assets/images/ic_chat_circle_button_bg.svg"),
                                  Align(
                                      alignment: Alignment.center,
                                      child: SvgPicture.asset(
                                        "assets/images/ic_setting_login_activity.svg",
                                        color: Colors.black,
                                        width: 14,
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${snapshot.value['device_model']}"),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Active Now",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            ?.copyWith(
                                                color: Color(0xff007F00)),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Icon(
                                        Icons.circle,
                                        size: 10,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "${snapshot.value['device_name']}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            ?.copyWith(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "Last Login ${snapshot.value['created_time']}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(color: Colors.black),
                                  ),
                                  snapshot.value['device'] == deviceId ? Text("Current Device") :TextButton(onPressed: (){
                                    reference?.child("${snapshot.key}").remove();
                                  }, child: Text("Logout from this device"))
                                ],
                              ),
                            ),

                          ],
                        ),
                      );
                    })
            ],
          ),
        ),
      ),
    );
  }
}
