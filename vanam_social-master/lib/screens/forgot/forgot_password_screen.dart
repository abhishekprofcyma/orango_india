import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vanam_social/screens/components/vanam_button.dart';
import 'package:vanam_social/screens/verification/verification_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _contentAnimation;
  late Animation _emailEditTextAnimation;
  late Animation _sendButtonAnimation;
  String _mobile = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    _contentAnimation = Tween(begin: 0.0, end: 34.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.00, 0.10, curve: Curves.easeOut)));
    _emailEditTextAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Interval(0.15, 0.25, curve: Curves.easeOut)));
    _sendButtonAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.20, 0.30, curve: Curves.easeOut)));
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: 90,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffFFCC00), Color(0xffFFEC3A)],
                begin: Alignment(0, -1),
                end: Alignment(0, 0),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 56,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Forgot Password",
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: _contentAnimation.value),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Please type your  Phone Number below to let us help you out!",
                    style: Theme.of(context).textTheme.caption?.copyWith(
                            color: Color(
                          0xff8D8D8D,
                        )),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Opacity(
                    opacity: _emailEditTextAnimation.value,
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Phone",
                          hintStyle: TextStyle(color: Color(0xffBEBEBE)),
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                                color: Color(0xffFFCC00), width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Color(0xffFFCC00),
                              width: 1.0,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _mobile = value;
                          });
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                        ]),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Transform.scale(
                          scale: _sendButtonAnimation.value,
                          child: PrimaryButton(
                              text: "Send",
                              press: () {
                                if (_mobile.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Please enter mobile number");
                                } else if (_mobile.length != 10) {
                                  Fluttertoast.showToast(
                                      msg: "Please enter valid mobile number");
                                } else {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          duration: Duration(milliseconds: 300),
                                          child: VerificationScreen(mobile: _mobile,)));
                                }
                              }))),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
