import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

class SearchHistoryScreen extends StatefulWidget {
  @override
  _SearchHistoryScreenState createState() => _SearchHistoryScreenState();
}

class _SearchHistoryScreenState extends State<SearchHistoryScreen> {
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
                  "Search history",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                child: Text(
                  "Only things you have searched for in the main search bar will appear here",
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              // ListView.builder(
              //     shrinkWrap: true,
              //     itemCount: 2,
              //     scrollDirection: Axis.vertical,
              //     physics: NeverScrollableScrollPhysics(),
              //     itemBuilder: (context, index) {
              //       return  Container(
              //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              //         child: Row(
              //           children: [
              //             Container(
              //               width: 32,
              //               height: 32,
              //               child: Stack(
              //                 children: [
              //                   SvgPicture.asset("assets/images/ic_chat_circle_button_bg.svg"),
              //                   Align(
              //                       alignment: Alignment.center,
              //                       child: SvgPicture.asset(
              //                         "assets/images/ic_setting_login_activity.svg",
              //                         color: Colors.black,
              //                         width: 14,
              //                       )),
              //                 ],
              //               ),
              //             ),
              //             SizedBox(
              //               width: 8,
              //             ),
              //             Column(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text("Pune, India"),
              //                 Row(
              //                   children: [
              //                     Text("Active Now",style: Theme.of(context).textTheme.caption?.copyWith(color: Color(0xff007F00)),),
              //                     SizedBox(width: 8,),
              //                     Icon(Icons.circle,size: 10,),
              //                     SizedBox(width: 4,),
              //                     Text("Device name",style: Theme.of(context).textTheme.caption?.copyWith(color: Colors.black),),
              //                   ],
              //                 )
              //               ],
              //             )
              //           ],
              //         ),
              //       );
              //     })
            ],
          ),
        ),
      ),
    );
  }
}
