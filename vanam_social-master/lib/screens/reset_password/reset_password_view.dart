import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vanam_social/data/cubit/reset_password/reset_password_cubit.dart';
import 'package:vanam_social/data/cubit/reset_password/reset_password_state.dart';
import 'package:vanam_social/screens/components/loading_view.dart';
import 'package:vanam_social/screens/components/vanam_button.dart';
import 'package:vanam_social/screens/home/home_screen.dart';
import 'package:vanam_social/screens/login/login_screen.dart';

import '../../constants.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String mobile;

  const ResetPasswordScreen({Key? key,required this.mobile}) : super(key: key);
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> with SingleTickerProviderStateMixin {
  late ResetPasswordCubit _cubit;
  late AnimationController _controller;
  late Animation _contentAnimation;
  late Animation _emailEditTextAnimation;
  late Animation _sendButtonAnimation;
  String _newPassword = "";
  String _rePassword = "";
  bool _passwordVisible = false;
  bool _rePasswordVisible = false;

  @override
  void initState() {
  _cubit = BlocProvider.of<ResetPasswordCubit>(context,listen: false);
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
                    "Reset Password",
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: _contentAnimation.value),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Please type your new password",
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
                      obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          hintText: "New Password",
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
                            _newPassword = value;
                          });
                        },
                       ),
                  ),
                  SizedBox(height: 8,),
                  Opacity(
                    opacity: _emailEditTextAnimation.value,
                    child: TextFormField(
                      obscureText: !_rePasswordVisible,
                        decoration: InputDecoration(
                          hintText: "Re Password",
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
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _rePasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: kPrimaryColor,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _rePasswordVisible = !_rePasswordVisible;
                              });
                            },
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _rePassword = value;
                          });
                        },
                        ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Transform.scale(
                          scale: _sendButtonAnimation.value,
                          child: PrimaryButton(
                              text: "Change",
                              press: () {
                                if (_newPassword.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Please enter new password");
                                } else if (_rePassword.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Please enter repeat password");
                                } else if (_newPassword != _rePassword) {
                                  Fluttertoast.showToast(
                                      msg: "Password not matched");
                                } else {
                                  _cubit.resetPassword(context, widget.mobile, _newPassword, _rePassword);
                                }
                              }))),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
          BlocConsumer<ResetPasswordCubit,ResetPasswordState>(builder: (context,state){
            if(state is ResetPasswordLoading){
              return LoadingView();
            }
            return Container();
          }, listener: (context,state){})
        ],
      ),
    );
  }
}