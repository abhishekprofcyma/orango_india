import 'dart:async';
import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vanam_social/data/local/shared_pref.dart';
import 'package:vanam_social/screens/components/bottom_bar/circular_bottom/circular_bottom_bar.dart';
import 'package:vanam_social/screens/components/bottom_bar/convex_bottom_navigation.dart';
import '../../../constants.dart';

class VanamBottomNavigationBarView extends StatefulWidget {
  final Function(int currentPage) onClick;
  final int index;

  const VanamBottomNavigationBarView({Key? key, required this.onClick,required this.index})
      : super(key: key);

  @override
  _VanamBottomNavigationBarViewState createState() =>
      _VanamBottomNavigationBarViewState();
}

class _VanamBottomNavigationBarViewState
    extends State<VanamBottomNavigationBarView> {
  int currentIndex = 0;
  DatabaseReference? reference;
  int? messageCount = 0;
  int? friendCount = 0;
  int? notificationCount = 0;




  double bottomNavBarHeight = 60;



  late CircularBottomNavigationController _navigationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      currentIndex = widget.index;
    });
    _navigationController = new CircularBottomNavigationController(currentIndex);
    getFirebaseCount();
  }

  void getFirebaseCount() async{
    String? userid = await getUserId();
    reference =
        FirebaseDatabase.instance.reference().child("notification").child(userid.toString());
    Timer(Duration(seconds: 0), () {
      try {
        reference!.onValue.listen((event) async {
          print("notification count ");
          LinkedHashMap<Object?, Object?> data = event.snapshot.value;
          data.forEach((key, value) {
            LinkedHashMap<Object?, Object?> subData =
            value as LinkedHashMap<Object?, Object?>;
            if (key == "friend") {
              setState(() {
                friendCount = int.parse(subData.values.first.toString());
              });
            }
            if (key == "message") {
              setState(() {
                messageCount = int.parse(subData.values.first.toString());
              });
            }

            if (key == "notification") {
              setState(() {
                notificationCount = int.parse(subData.values.first.toString());
              });
            }

          });

          print("notification count ${data.toString()}");
        });
      } catch (e) {
        print("error $e");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // return ConvexAppBar(
    //   style: TabStyle.reactCircle,
    //   curveSize: 0,
    //   items: [
    //     TabItem(icon: Icons.home, title: 'Home'),
    //     TabItem(icon: Icons.map, title: 'Discovery'),
    //     TabItem(icon: Icons.add, title: 'Add'),
    //     TabItem(icon: Icons.message, title: 'Message'),
    //     TabItem(icon: Icons.people, title: 'Profile'),
    //   ],
    //   initialActiveIndex: 2, //optional, default as 0
    //   onTap: (int i) => print('click index=$i'),
    // );

   /* return ConvexBottomNavigation(
      barBackgroundColor: Theme.of(context).backgroundColor,
      activeIconColor: Colors.white,
      inactiveIconColor: Theme.of(context).backgroundColor,
      textColor: Color(0xff979797),
      bigIconPadding: 0.0,
      circleSize: CircleSize.BIG,
      smallIconPadding: 0.0,
      circleColor: kPrimaryColor,
      tabs: [
        TabData(
          icon: SvgPicture.asset(
            "assets/images/ic_home_icon.svg",
            color: currentIndex == 0 ? Colors.white : Colors.black,
          ),
          title: "Home",
        ),
        TabData(
          icon: SvgPicture.asset(
            "assets/images/ic_connects.svg",
            color: currentIndex == 1 ? Colors.white : Colors.black,
          ),
          title: "Connect",
        ),
        TabData(
          icon: SvgPicture.asset(
            "assets/images/ic_notofication.svg",
            color: currentIndex == 2 ? Colors.white : Colors.black,
          ),
          title: "Notification",
        ),
        TabData(
          icon: SvgPicture.asset(
            "assets/images/ic_messages.svg",
            color: currentIndex == 3 ? Colors.white : Colors.black,
          ),
          title: "Messages",
        ),
      ],
      initialSelection: widget.index,
      onTabChangedListener: (value) {
        onTabChanged(value);
        setState(() {
          currentIndex = value;
        });
      },

    );*/

    List<TabItem> tabItems = List.of([
      new TabItem(Icons.home, "Home", kPrimaryColor, ),
      new TabItem(Icons.people, "Connect", kPrimaryColor, ),
      new TabItem(Icons.notifications, "Notification", kPrimaryColor),
      new TabItem(Icons.message, "Messages", kPrimaryColor),
    ]);
      return CircularBottomNavigation(
        tabItems,
        controller: _navigationController,
        barHeight: bottomNavBarHeight,
        barBackgroundColor: Colors.white,
        selectedPos: currentIndex,
        animationDuration: Duration(milliseconds: 600),
        selectedCallback: (int selectedPos) {
          setState(() {
            currentIndex = selectedPos;
            print("......${_navigationController.value}");
            onTabChanged(selectedPos);
          });
        },
      );

  }

  void onTabChanged(int value) {
    print("VanamBottomNavigationBarView index $value");
    setState(() {
      currentIndex = value;
      widget.onClick(value);
    });
    setState(() {});
  }
}

class VanamBottomNavigationBarView1 extends StatelessWidget {
  final int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: kPrimaryColor,
        selectedIconTheme: IconThemeData(
          color: kPrimaryColor,
        ),
        selectedLabelStyle: TextStyle(color: kPrimaryColor),
        unselectedItemColor: Color(0xff0F0F0F),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: _currentIndex,
        onTap: (value) {
          //setState(() => _currentIndex = value);
        },
        items: [
          BottomNavigationBarItem(
            label: 'Store',
            icon: SvgPicture.asset(
              "assets/images/ic_home_icon.svg",
              color: _currentIndex == 0 ? Color(0xff38ab00) : Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Cart',
            icon: SvgPicture.asset(
              "assets/images/ic_connects.svg",
              color: _currentIndex == 1 ? Color(0xff38ab00) : Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Offers',
            icon: SvgPicture.asset(
              "assets/images/ic_notification.svg",
              color: _currentIndex == 2 ? Color(0xff38ab00) : Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Wishlist',
            icon: SvgPicture.asset(
              "assets/images/ic_messages.svg",
              color: _currentIndex == 3 ? Color(0xff38ab00) : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
