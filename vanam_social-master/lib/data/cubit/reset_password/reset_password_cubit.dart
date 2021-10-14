import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vanam_social/data/cubit/reset_password/reset_password_state.dart';
import 'package:vanam_social/data/remote/model/reset_password/reset_password_response.dart';
import 'package:vanam_social/data/remote/repository.dart';
import 'package:vanam_social/screens/login/login_screen.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState>{
  Repository _repository = Repository();


  ResetPasswordCubit(ResetPasswordState state) : super(state);


  resetPassword(BuildContext context,String mobileEmail,String password,String cPassword) async {
    var map = Map<String,String>();
    map['mobile_number'] = mobileEmail;
    map['new_password'] = password;
    map['c_password'] = cPassword;
    emit(ResetPasswordLoading());
    try {
      ResetPasswordResponse response =
      await _repository.apiResetPassword(context,map);
      if(response.success){
        emit(ResetPasswordLoaded(response: response));
        Fluttertoast.showToast(msg: "Password changed successfully");
        Navigator.pushAndRemoveUntil(context,  PageTransition(
            type: PageTransitionType.rightToLeft,
            duration: Duration(milliseconds: 300),
            child: LoginScreen()), (route) => false);
      }else{
        Fluttertoast.showToast(msg: "Password change failed");
      }
    } catch (e) {
      print("error: ${e.toString()}");
      Fluttertoast.showToast(msg: "Password change failed");
      emit(ResetPasswordError("Password change failed"));
      print(e);
    }
  }



}