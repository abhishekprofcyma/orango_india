import 'dart:async';
import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:vanam_social/data/local/shared_pref.dart';
import 'package:vanam_social/screens/components/android_firebase_message_manager.dart';
import 'package:vanam_social/screens/home/components/vanam_bottom_navigation_bar_view.dart';
import 'package:vanam_social/screens/home/connect/connect_tab_view.dart';
import 'package:vanam_social/screens/home/home/home_tab_view.dart';
import 'package:vanam_social/screens/home/message/message_tab_view.dart';
import 'package:vanam_social/screens/home/notification/notification_tab_view.dart';

class HomeScreen extends StatefulWidget {
  final int index;

  const HomeScreen({Key? key, this.index = 0}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  String firebaseToken = "";
  FirebaseMessaging? messaging;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      currentIndex = widget.index;
    });

    accessDeviceFirebaseToken();
    String token =  AndroidFirebaseMessageManager().init()??"";
    setState(() {
      firebaseToken = token;
    });

  }

  accessDeviceFirebaseToken(){
    messaging = FirebaseMessaging.instance;
    messaging!.subscribeToTopic("messaging");
    messaging!.getToken().then((value) {
      print("firebase token-- "+value!);
      firebaseToken = value;
      setState(() {
        firebaseToken = value;
      });
    });
  }




  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      HomeTabView(),
      ConnectTabView(),
      NotificationTabView(),
      MessageTabView()
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: tabs[currentIndex],
      bottomNavigationBar: VanamBottomNavigationBarView(
        onClick: (index) {
          print("HomeScreen index $index");
          setState(() {
            currentIndex = index;
          });
          tabChanged();
        },
        index: currentIndex,
      ),
    );
  }
  void tabChanged(){
    setState(() {
    });
  }
}
