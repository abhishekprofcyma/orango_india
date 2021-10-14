import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vanam_social/screens/components/vanam_button.dart';

import '../../../constants.dart';

class FriendConnectionScreen extends StatefulWidget {
  @override
  _FriendConnectionScreenState createState() => _FriendConnectionScreenState();
}

class _FriendConnectionScreenState extends State<FriendConnectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kPrimaryColor),
        leading: IconButton(
          icon: SvgPicture.asset("assets/images/ic_back_arrow_green.svg"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Connects",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body:ListView.builder(
        shrinkWrap: true,
          itemCount: 8,
           scrollDirection: Axis.vertical,
          itemBuilder: (context,index){
        return Container(
          padding:
          const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Color(0xff000000).withOpacity(0.1),
                    offset: Offset(0.3, -.07),
                    spreadRadius: 1)
              ]),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80"),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                  child: Text(
                    "Teri dactlyl",
                    style: Theme.of(context).textTheme.subtitle1,
                  )),
              index != 5 ? PrimaryButton(text: "Add",press: (){},) : Container()
            ],
          ),
        );
      }),
    );
  }
}
