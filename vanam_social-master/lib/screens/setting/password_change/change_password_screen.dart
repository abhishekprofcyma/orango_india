import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vanam_social/data/cubit/profile/profile_cubit.dart';
import 'package:vanam_social/data/cubit/profile/profile_state.dart';
import 'package:vanam_social/screens/components/loading_view.dart';
import 'package:vanam_social/screens/components/vanam_button.dart';
import 'package:vanam_social/screens/forgot/forgot_password_screen.dart';
import 'package:vanam_social/screens/home/home_screen.dart';
import 'package:vanam_social/screens/login/login_screen.dart';
import 'package:vanam_social/screens/signup/signup_screen.dart';

import '../../../constants.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late ProfileCubit _cubit;
  late Animation _contentAnimation;
  late Animation _emailEditTextAnimation;
  late Animation _passwordEditTextAnimation;
  late Animation _forgotPasswordAnimation;
  late Animation _loginButtonAnimation;
  late Animation _signUpAnimation;
  bool _oldPasswordVisible = false;
  bool _newPasswordVisible = false;
  bool _cPasswordVisible = false;
  String oldPassword = "";
  String newPassword = "";
  String cPassword = "";


  @override
  void initState() {
    _cubit = BlocProvider.of(context,listen: false);
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
      backgroundColor: Theme.of(context).backgroundColor,
      body: BlocConsumer<ProfileCubit,ProfileState>(builder: (context,state){
        return  Stack(
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
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 56,
              child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 1.3,
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: Icon(Icons.close,color: Color(0xff007F00),)),
                        Text("Change Password",style: Theme.of(context).textTheme.headline6,),
                        Container(width: 32,)
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Opacity(
                      opacity: _emailEditTextAnimation.value,
                      child: TextFormField(
                        obscureText: !_oldPasswordVisible,
                        onChanged: (value){
                          setState(() {
                            oldPassword = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Old password",
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
                              _oldPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: kPrimaryColor,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _oldPasswordVisible = !_oldPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16,),
                    Opacity(
                      opacity: _emailEditTextAnimation.value,
                      child: TextFormField(
                        obscureText: !_newPasswordVisible,
                        onChanged: (value){
                          setState(() {
                            newPassword = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "New password",
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
                              _newPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: kPrimaryColor,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _newPasswordVisible = !_newPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Opacity(
                      opacity: _passwordEditTextAnimation.value,
                      child: TextFormField(
                        obscureText: !_cPasswordVisible,
                        onChanged: (value){
                          setState(() {
                            cPassword = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
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
                              _cPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: kPrimaryColor,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _cPasswordVisible = !_cPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Transform.scale(
                            scale: _loginButtonAnimation.value,
                            child: PrimaryButton(text: "Save", press: () {
                              if(oldPassword.isEmpty){
                                Fluttertoast.showToast(msg: "Please enter old Password");
                              }else if(newPassword.isEmpty){
                                Fluttertoast.showToast(msg: "Please enter new Password");
                              }else if(cPassword.isEmpty){
                                Fluttertoast.showToast(msg: "Please enter confirm Password");
                              }else if(newPassword != cPassword){
                                Fluttertoast.showToast(msg: "Password not matched");
                              }else {
                                _cubit.changePassword(context, oldPassword, newPassword, cPassword);
                              }
                            }))),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
            if(state is ProfileChangePasswordLoading)Center(child: LoadingView(),),
          ],
        );
      }, listener: (context,state){
        if(state is ProfileChangePasswordCompleted){
          Fluttertoast.showToast(msg: "Password Changed Successfully");
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
        }
      }),
    );
  }
}