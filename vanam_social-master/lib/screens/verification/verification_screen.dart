import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:vanam_social/constants.dart';
import 'package:vanam_social/data/cubit/otp/otp_cubit.dart';
import 'package:vanam_social/data/cubit/otp/otp_state.dart';
import 'package:vanam_social/screens/components/loading_view.dart';
import 'package:vanam_social/screens/components/vanam_button.dart';
import 'package:vanam_social/screens/reset_password/reset_password_view.dart';

class VerificationScreen extends StatefulWidget {
  final String mobile;

  const VerificationScreen({Key? key, required this.mobile}) : super(key: key);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen>
    with SingleTickerProviderStateMixin {
  late OtpCubit _cubit;
  late AnimationController _controller;
  TextEditingController otpController = TextEditingController();
  late Animation _contentAnimation;
  late Animation _emailEditTextAnimation;
  late Animation _sendButtonAnimation;
  String otp = "";
  String otpFilled = "";
  Timer? _timer;
  int _start = 60;
  bool isTimeOver = false;

  @override
  void initState() {
    _cubit = BlocProvider.of<OtpCubit>(context, listen: false);
    super.initState();
    generateOtp();
    _cubit.otpSend(context, widget.mobile, otp);
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
        curve: Interval(0.30, 0.40, curve: Curves.easeOut)));
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
  }

  String generateOtp() {
    var rndnumber = "";
    var rnd = new Random();
    for (var i = 0; i < 6; i++) {
      rndnumber = rndnumber + rnd.nextInt(9).toString();
    }
    print(rndnumber);
    setState(() {
      otp = rndnumber;
    });
    return rndnumber;
  }

  void _startCountDown() {
    _start = 60;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            isTimeOver = true;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Verification",
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: _contentAnimation.value),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "We have just you an OTP on your Phone, please enter below to verify",
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
                    child: PinCodeTextField(
                      controller: otpController,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10),
                        borderWidth: 2,
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                        activeColor: kPrimaryColor,
                        disabledColor: Colors.white,
                        inactiveColor: kPrimaryColor.withOpacity(0.3),
                        selectedColor: kPrimaryColor,
                      ),
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      keyboardType: TextInputType.number,
                      backgroundColor: Colors.white,
                      cursorColor: Colors.black,
                      boxShadows: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      animationDuration: Duration(milliseconds: 300),
                      onChanged: (value) {
                        setState(() {
                          otpController.text = value;
                          otpFilled = value;
                        });
                      },
                      appContext: context,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  if (isTimeOver == false) Text("Resend otp in $_start sec."),
                  if (isTimeOver == true)
                    OutlinedButton(onPressed: () {}, child: Text("Resend OTP")),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Opacity(
                        opacity: otpController.text.length == 6 ? 1 : 0,
                        child: Transform.scale(
                          scale: _sendButtonAnimation.value,
                          child: PrimaryButton(
                            text: "Verify",
                            press: () {
                              if(otp != otpFilled){
                                Fluttertoast.showToast(msg: "OTP not matched");
                              }else{
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>ResetPasswordScreen(mobile: widget.mobile,)), (route) => false);
                              }
                            },
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
          BlocConsumer<OtpCubit, OtpState>(builder: (context, state) {
            if (state is OtpLoading) {
              return LoadingView();
            }
            return Container();
          }, listener: (context, state) {
            if (state is OtpLoaded) {
              _startCountDown();
            }
          })
        ],
      ),
    );
  }
}
