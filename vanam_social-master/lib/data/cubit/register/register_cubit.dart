import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vanam_social/data/local/shared_pref.dart';
import 'package:vanam_social/data/remote/model/login/login_fail_response.dart';
import 'package:vanam_social/data/remote/model/login/login_response.dart';
import 'package:vanam_social/data/remote/model/register/register_response.dart';
import 'package:vanam_social/data/remote/repository.dart';
import 'package:vanam_social/screens/home/home_screen.dart';

import '../../../main.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState>{
  Repository _repository = Repository();


  RegisterCubit(RegisterState state) : super(state);


  fetchRegister(context,String name,String email,String password,String cPassword,String mobile,String gender,String firebaseToken) async {
    var map = Map<String,String>();
    map['mobile_number'] = mobile;
    map['password'] = password;
    map['name'] = name;
    map['email'] = email;
    map['c_password'] = cPassword;
    map['gender'] = gender;
    map['device_key'] = firebaseToken;
    emit(RegisterLoading());
    try {
      RegisterRespnse registerRespnse =
      await _repository.fetchRegisterData(context,map);
      if(registerRespnse.success!){
        saveToken("Bearer ${registerRespnse.data!.token}");
        saveLogin(true);
        saveUserId(registerRespnse.data!.userId!.toString());
        saveUserName(registerRespnse.data!.name.toString());
        saveMobile(mobile);
        emit(RegisterLoaded(response: registerRespnse));
        manageLoginActivity(context,registerRespnse);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
        Fluttertoast.showToast(msg: "Register successfully");

      }else{
        Fluttertoast.showToast(msg: "${RegisterError(registerRespnse.toString().substring(registerRespnse.toString().indexOf("[")+1,registerRespnse.toString().indexOf("]"))).error}");
      }
    } catch (e) {
      emit(RegisterError(e.toString().substring(e.toString().indexOf("[")+1,e.toString().indexOf("]"))));
      Fluttertoast.showToast(msg: "${RegisterError(e.toString().substring(e.toString().indexOf("[")+1,e.toString().indexOf("]"))).error}");
      print(e);
    }
  }
  manageLoginActivity(BuildContext context,RegisterRespnse registerRespnse)async{
    String id = await getDeviceId();
    String deviceName = await getDeviceName();
    String deviceModel = await getDeviceModel();
    DatabaseReference reference=
    FirebaseDatabase.instance.reference().child("login").child(registerRespnse.data?.userId.toString()??"");
    reference.push().set({
      'device_id': id,
      'device_name': deviceName,
      'device_model': deviceModel,
      'created_time': DateTime.now().toString(),
    });
  }

}