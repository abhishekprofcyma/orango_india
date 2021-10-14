import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vanam_social/screens/components/vanam_button.dart';

import '../../constants.dart';

class IntroItem{
  final String title;
  final String desc;

  IntroItem(this.title, this.desc);
}

class IntroScreen extends StatefulWidget {
  final int indexPage;

  const IntroScreen({Key? key,required this.indexPage}) : super(key: key);
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      currentIndex = widget.indexPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<IntroItem> introTitle = [
      IntroItem("Make Friends", "Make new friends share thought and moments and more"),
      IntroItem("Create Group", "Create group with friends and family and chat with them"),
      IntroItem("Vendor Zone", "Find the service you need in your local area. Name it, Find it"),
    ];

    var listIntros = <Widget>[intoFirst(), intoSecond(), intoThird()];
    Future<bool> _onWillPop() async {
      if(currentIndex == 0 ){
        return false;
      }else{
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(seconds: 2),
                pageBuilder: (_, __, ___) => IntroScreen(indexPage: currentIndex-1,)));
      }
      return false;
    }
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 1.6,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listIntros.length,
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return listIntros[currentIndex];
                  },
                ),
              ),
              Text(
                "${introTitle[currentIndex].title}",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                    "${introTitle[currentIndex].desc}",textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),),
              ),
              SizedBox(
                height: 16,
              ),
              PrimaryButton(
                text: "${currentIndex != 2 ? "Next" : "Get Started"}",
                press: () {
                 if(currentIndex != 2) {
                   Navigator.push(
                       context,
                       PageRouteBuilder(
                           transitionDuration: Duration(seconds: 2),
                           pageBuilder: (_, __, ___) =>
                               IntroScreen(indexPage: currentIndex + 1,)));
                 }else{
                   Navigator.pushNamed(context, "/login");
                 }
                },
                padding: const EdgeInsets.symmetric(horizontal: 46, vertical: 12),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 0; i < listIntros.length; i++)
                    if (i == currentIndex) ...[circleBar(true)] else
                      circleBar(false),
                ],
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget intoFirst() {
    return Container(
      child: Stack(
        children: [
          Image.asset(
            "assets/images/ic_intro_bg.png",
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth,
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: -40,
              child: Image.asset("assets/images/ic_intro_first_person.png")),
          Container(
            height: MediaQuery.of(context).size.height / 1.5,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 32,
                  child: Hero(
                    tag: "intro_smile",
                    child: Image.asset(
                      "assets/images/ic_intro_face_lt.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 12,
                  top: 56,
                  child: Hero(
                    tag: "intro_glasses",
                    child: Image.asset(
                      "assets/images/ic_intro_face_rt.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 100,
                  child: Hero(
                    tag: "intro_down",
                    child: Image.asset(
                      "assets/images/ic_intro_face_bl.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 40,
                  child: Image.asset(
                    "assets/images/ic_intro_face_br.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget intoSecond() {
    return Container(
      child: Stack(
        children: [
          Image.asset(
            "assets/images/ic_intro_bg.png",
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth,
          ),
          Positioned(
              left: 0,
              right: 0,
              top: -160,
              child: Image.asset("assets/images/ic_intro_second_person.png")),
          Container(
            height: MediaQuery.of(context).size.height / 1.5,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 32,
                  child: Hero(
                    tag: "intro_glasses",
                    child: Image.asset(
                      "assets/images/ic_intro_face_rt.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 56,
                  top: 56,
                  child: Transform.rotate(
                    angle: 45,
                    child: Hero(
                      tag: "intro_down",
                      child: Image.asset(
                        "assets/images/ic_intro_face_bl.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 8,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Transform.rotate(
                      angle: 45,
                      child: Transform.rotate(
                        angle: 75,
                        child: Image.asset(
                          "assets/images/ic_intro_hey.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: -40,
                  bottom: 0,
                  child: Hero(
                    tag: "intro_smile",
                    child: Image.asset(
                      "assets/images/ic_intro_face_smile_big.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget intoThird() {
    return Container(
      child: Stack(
        children: [
          Image.asset(
            "assets/images/ic_intro_bg.png",
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth,
          ),
          Positioned(
              left: 0,
              bottom: 35,
              child: Image.asset("assets/images/ic_intro_third_person.png")),
          Container(
            height: MediaQuery.of(context).size.height / 1.5,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 32,
                  child: Hero(
                    tag: "intro_smile",
                    child: Image.asset(
                      "assets/images/ic_intro_face_lt.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                    top: -120,
                    left: 0,
                    right: 0,
                    child:
                        Image.asset("assets/images/ic_intro_message_big.png")),
                Positioned(
                  right: 12,
                  top: 56,
                  child: Hero(
                    tag: "intro_glasses",
                    child: Image.asset(
                      "assets/images/ic_intro_face_rt.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  bottom: 30,
                  right: 110,
                  child: Center(
                    child: Image.asset(
                      "assets/images/ic_intro_circle_heart.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: 90,
                  bottom: 130,
                  child: Hero(
                    tag: "intro_down",
                    child: Image.asset(
                      "assets/images/ic_intro_face_bl.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 20,
                  child: Image.asset(
                    "assets/images/ic_intro_face_br.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
          color: isActive ? kPrimaryColor : kColorGrey,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }
}
