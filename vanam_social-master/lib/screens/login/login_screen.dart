import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vanam_social/data/cubit/login/login_cubit.dart';
import 'package:vanam_social/data/cubit/login/login_state.dart';
import 'package:vanam_social/screens/components/android_firebase_message_manager.dart';
import 'package:vanam_social/screens/components/loading_view.dart';
import 'package:vanam_social/screens/components/vanam_button.dart';
import 'package:vanam_social/screens/forgot/forgot_password_screen.dart';
import 'package:vanam_social/screens/home/home_screen.dart';
import 'package:vanam_social/screens/signup/signup_screen.dart';

import '../../constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late LoginCubit _loginCubit;
  late AnimationController _controller;

  late Animation _contentAnimation;
  late Animation _emailEditTextAnimation;
  late Animation _passwordEditTextAnimation;
  late Animation _forgotPasswordAnimation;
  late Animation _loginButtonAnimation;
  late Animation _signUpAnimation;
  bool _passwordVisible = false;
  String mobile = "";
  String password = "";
  FirebaseMessaging? messaging;
  String firebaseToken = "";


  @override
  void initState() {
    _loginCubit = BlocProvider.of<LoginCubit>(context, listen: false);
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
    _passwordEditTextAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Interval(0.20, 0.30, curve: Curves.easeOut)));
    _forgotPasswordAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Interval(0.25, 0.35, curve: Curves.easeOut)));
    _loginButtonAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.30, 0.40, curve: Curves.easeOut)));
    _signUpAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.35, 0.35, curve: Curves.easeOut)));
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
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
  void dispose() {
    // TODO: implement dispose
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
              height: MediaQuery.of(context).size.height / 1.3,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  color: Colors.white),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Login",
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: _contentAnimation.value),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Please login to continue",
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
                        decoration: InputDecoration(
                          hintText: "Email or Phone",
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
                            mobile = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Opacity(
                      opacity: _passwordEditTextAnimation.value,
                      child: TextFormField(
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(color: Color(0xffBEBEBE)),
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
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
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: kPrimaryColor,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Transform.scale(
                          scale: _forgotPasswordAnimation.value,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        duration: Duration(milliseconds: 400),
                                        child: ForgotPasswordScreen()));
                              },
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(color: Color(0xff269D2E)),
                              )),
                        )),
                    SizedBox(
                      height: 8,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Transform.scale(
                        scale: _loginButtonAnimation.value,
                        child: PrimaryButton(
                            text: "Login",
                            press: () async{
                              if(mobile.isEmpty){
                                Fluttertoast.showToast(msg: "Please enter email or mobile");
                              }else if(password.isEmpty){
                                Fluttertoast.showToast(msg: "Please enter password");
                              }else {

                                _loginCubit.fetchLogin(
                                    context, mobile, password, firebaseToken);
                              }
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: Transform.scale(
                        scale: _signUpAnimation.value,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.bottomToTop,
                                    duration: Duration(milliseconds: 300),
                                    child: SignUpScreen()));
                          },
                          child: RichText(
                            text: TextSpan(
                              text: "Don't have an account? ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(color: Color(0xff3F3F3F)),
                              children: [
                                TextSpan(
                                  text: "SIGN UP",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                          color: Color(0xff37AB01),
                                          fontWeight: FontWeight.w500,
                                          decoration: TextDecoration.underline),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          BlocConsumer<LoginCubit, LoginState>(
              builder: (context, state) {
                if (state is LoginLoading) {
                  return LoadingView();
                }
                return Container();
              },
              listener: (context, state) {}),
        ],
      ),
    );
  }

  void launchHomeScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
