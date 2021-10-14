import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vanam_social/data/cubit/register/register_cubit.dart';
import 'package:vanam_social/data/cubit/register/register_state.dart';
import 'package:vanam_social/screens/components/android_firebase_message_manager.dart';
import 'package:vanam_social/screens/components/loading_view.dart';
import 'package:vanam_social/screens/components/vanam_button.dart';
import 'package:vanam_social/screens/login/login_screen.dart';

import '../../constants.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  late RegisterCubit _cubit;
  late AnimationController _controller;
  late Animation _contentAnimation;
  late Animation _nameEditTextAnimation;
  late Animation _emailEditTextAnimation;
  late Animation _passwordEditTextAnimation;
  late Animation _mobilePasswordAnimation;
  late Animation _genderAnimation;
  late Animation _loginButtonAnimation;
  late Animation _signUpAnimation;
  bool _passwordVisible = false;
  FirebaseMessaging? messaging;
  String firebaseToken = "";
  String _fullName = "";
  String _email = "";
  String _password = "";
  String _mobile = "";
  String _gender = "";

  @override
  void initState() {
    _cubit = BlocProvider.of<RegisterCubit>(context, listen: false);
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    _contentAnimation = Tween(begin: 0.0, end: 34.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.00, 0.10, curve: Curves.easeOut)));
    _nameEditTextAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Interval(0.15, 0.25, curve: Curves.easeOut)));
    _emailEditTextAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Interval(0.20, 0.30, curve: Curves.easeOut)));
    _passwordEditTextAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Interval(0.25, 0.35, curve: Curves.easeOut)));
    _mobilePasswordAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Interval(0.30, 0.40, curve: Curves.easeOut)));
    _genderAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.35, 0.45, curve: Curves.easeOut)));
    _loginButtonAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.40, 0.50, curve: Curves.easeOut)));
    _signUpAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.45, 0.55, curve: Curves.easeOut)));
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
                      "Create Account",
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: _contentAnimation.value),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Please create account to continue",
                      style: Theme.of(context).textTheme.caption?.copyWith(
                              color: Color(
                            0xff8D8D8D,
                          )),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Opacity(
                      opacity: _nameEditTextAnimation.value,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Full name",
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
                            _fullName = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Opacity(
                      opacity: _emailEditTextAnimation.value,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Email",
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
                            _email = value;
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
                            _password = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Opacity(
                      opacity: _mobilePasswordAnimation.value,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Color(0xffFFCC00))),
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/images/ic_flag_india.svg"),
                            SizedBox(
                              width: 8,
                            ),
                            Text("+91"),
                            Expanded(
                              child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintText: "0000 000 0000",
                                      hintStyle:
                                          TextStyle(color: Color(0xffBEBEBE)),
                                      isDense: true,
                                      contentPadding:
                                          EdgeInsets.fromLTRB(8, 12, 16, 12),
                                      border: InputBorder.none),
                                  onChanged: (value) {
                                    setState(() {
                                      _mobile = value;
                                    });
                                  },
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(10),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Transform.scale(
                      scale: _genderAnimation.value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                _gender = "female";
                              });
                            },
                            child: Container(
                              padding: _gender == "female"
                                  ? const EdgeInsets.all(6)
                                  : const EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.grey),
                              child: SvgPicture.asset(
                                  "assets/images/ic_gender_female.svg"),
                            ),
                          ),
                          SizedBox(
                            width: 32,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _gender = "male";
                              });
                            },
                            child: Container(
                                padding: _gender == "male"
                                    ? const EdgeInsets.all(6)
                                    : const EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.grey),
                                child: SvgPicture.asset(
                                    "assets/images/ic_gender_male.svg")),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Transform.scale(
                        scale: _signUpAnimation.value,
                        child: PrimaryButton(
                          text: "Sign up",
                          press: () {
                            if (_fullName.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Please enter fullname");
                            } else if (_email.isEmpty) {
                              Fluttertoast.showToast(msg: "Please enter email");
                            } else if (!_email.isValidEmail()) {
                              Fluttertoast.showToast(
                                  msg: "Please enter valid email address");
                            } else if (_password.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Please enter password");
                            } else if (_mobile.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Please enter mobile number");
                            } else if (_gender.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Please select gender");
                            } else {
                              _cubit.fetchRegister(context, _fullName, _email,
                                  _password, _password, _mobile, _gender, firebaseToken);
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Transform.scale(
                      scale: _loginButtonAnimation.value,
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.topToBottom,
                                    duration: Duration(seconds: 1),
                                    child: LoginScreen()));
                          },
                          child: RichText(
                            text: TextSpan(
                              text: "Already have an account? ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(color: Color(0xff3F3F3F)),
                              children: [
                                TextSpan(
                                  text: "Login",
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
          BlocConsumer<RegisterCubit, RegisterState>(
              builder: (context, state) {
                if(state is RegisterLoading){
                  return LoadingView();
                }
                return Container();
              }, listener: (context, state) {})
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
