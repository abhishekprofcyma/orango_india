import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vanam_social/constants.dart';
import 'package:vanam_social/screens/components/vanam_button.dart';

class TestView extends StatefulWidget {
  @override
  _TestViewState createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextButton.icon(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (builder){
                      return new Container(
                        height: 350.0,
                        color: Colors.transparent, //could change this to Color(0xFF737373),
                        //so you don't have to change MaterialApp canvasColor
                        child: new Container(
                            decoration: new BoxDecoration(
                                color: Colors.white,
                                borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(10.0),
                                    topRight: const Radius.circular(10.0))),
                            child: new Center(
                              child: new Text("This is modal sheet"),
                            )),
                      );
                    }
                );
              },
              icon: SvgPicture.asset(
                "assets/images/ic_share.svg",
                height: 18,
                width: 18,
              ),
              label: Text(
                "Share",
                style: TextStyle(color: Colors.black),
              ),
            ),
            shareView()
          ],
        ),
      ),
    );
  }

  Widget shareView(){
    return Container(
      height: 350.0,
      color: Colors.transparent, //could change this to Color(0xFF737373),
      child: new Container(
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0))),
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage("$ImageBaseUrl"),
                ),
                title: Text("Jayesh Shinde"),
                subtitle: Row(
                  children: [
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        width: 80,
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Theme.of(context).accentColor)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Public",style: TextStyle(color: Theme.of(context).primaryColor),),
                            SizedBox(width: 4,),
                            Icon(Icons.arrow_drop_down_outlined)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Say something about this...",
                  ),
                  minLines: 3,
                  maxLines: 8,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerRight,
                    child: PrimaryButton(text: "Share Now", press: (){})),
              )
            ],
          )),
    );
  }
}
