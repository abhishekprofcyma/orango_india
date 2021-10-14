import 'dart:async';
import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vanam_social/data/local/shared_pref.dart';
import 'package:vanam_social/screens/components/vanam_icon_view.dart';
import 'package:vanam_social/screens/profile/profile_screen.dart';
import 'package:vanam_social/screens/search/search_screen.dart';

class VanamAppBarView extends StatefulWidget {
  final bool isSliverAppBar;
  final Function() onMenuTap;
  final bool isHomePage;

  VanamAppBarView(
      {Key? key, this.isSliverAppBar = false, required this.onMenuTap, this.isHomePage = false})
      : super(key: key);

  @override
  _VanamAppBarViewState createState() => _VanamAppBarViewState();
}

class _VanamAppBarViewState extends State<VanamAppBarView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFirebaseCount();
  }

  void getFirebaseCount() async{
    String? userid = await getUserId();

  }

  @override
  Widget build(BuildContext context) {
    // if (widget.isSliverAppBar == true) {
    //   return SliverAppBar(
    //     floating: true,
    //     backgroundColor: Colors.white,
    //     leadingWidth: 100.0,
    //     leading: IconButton(
    //       onPressed: widget.onMenuTap,
    //       icon: SvgPicture.asset("assets/images/ic_menu.svg"),
    //       padding: EdgeInsets.zero,
    //       constraints: BoxConstraints(),
    //     ),
    //     actions: [
    //       // IconButton(
    //       //   onPressed: () {
    //       //     Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
    //       //   },
    //       //   icon: SvgPicture.asset("assets/images/ic_search.svg"),
    //       //   padding: EdgeInsets.symmetric(horizontal: 8),
    //       //   constraints: BoxConstraints(),
    //       // ),
    //       IconButton(
    //         onPressed: () {
    //           Navigator.push(context,
    //               MaterialPageRoute(builder: (context) => ProfileScreen()));
    //         },
    //         icon: SvgPicture.asset("assets/images/ic_account.svg"),
    //         padding: EdgeInsets.symmetric(horizontal: 8),
    //         constraints: BoxConstraints(),
    //       ),
    //     ],
    //   );
    // } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Row(
          children: [
            IconButton(
              onPressed: widget.onMenuTap,
              icon: SvgPicture.asset("assets/images/ic_menu.svg"),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            ),
            if(!widget.isHomePage)VanamIconView(),
            Spacer(),
            // IconButton(
            //   onPressed: () {
            //     Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
            //   },
            //   icon: SvgPicture.asset("assets/images/ic_search.svg"),
            //   padding: EdgeInsets.symmetric(horizontal: 8),
            //   constraints: BoxConstraints(),
            // ),
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
              icon: SvgPicture.asset("assets/images/ic_account.svg"),
              padding: EdgeInsets.symmetric(horizontal: 8),
              constraints: BoxConstraints(),
            ),
          ],
        ),
      );
    //}
  }
}
