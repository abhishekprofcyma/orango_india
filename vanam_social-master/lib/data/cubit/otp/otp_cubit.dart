import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vanam_social/data/cubit/otp/otp_state.dart';
import 'package:vanam_social/data/remote/model/otp/otp_response.dart';
import 'package:vanam_social/data/remote/repository.dart';

class OtpCubit extends Cubit<OtpState>{
  Repository _repository = Repository();


  OtpCubit(OtpState state) : super(state);


  otpSend(BuildContext context,String mobileEmail,String otp) async {
    var map = Map<String,String>();
    map['mobile_number'] = mobileEmail;
    map['otp'] = otp;
    emit(OtpLoading());
    try {
      OtpResponse response =
      await _repository.apiOtpSend(context,map);
      if(response.success!){
        emit(OtpLoaded(response: response));
        Fluttertoast.showToast(msg: "Otp send successfully");
      }else{
        Fluttertoast.showToast(msg: "Otp failed to send");
      }
    } catch (e) {
      print("error: ${e.toString()}");
      Fluttertoast.showToast(msg: "Otp failed to send");
      emit(OtpError("otp failed to send"));
      print(e);
    }
  }



}