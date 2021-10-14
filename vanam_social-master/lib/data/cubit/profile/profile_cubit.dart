import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vanam_social/data/cubit/chat/chat_state.dart';
import 'package:vanam_social/data/cubit/profile/profile_state.dart';
import 'package:vanam_social/data/local/shared_pref.dart';
import 'package:vanam_social/data/remote/model/chat/chat_file_upload.dart';
import 'package:vanam_social/data/remote/model/post/post_list_response.dart';
import 'package:vanam_social/data/remote/model/profile/change_password_response.dart';
import 'package:vanam_social/data/remote/model/profile/profile_image_update_response.dart';
import 'package:vanam_social/data/remote/model/profile/user_basic_info_update_response.dart';
import 'package:vanam_social/data/remote/model/profile/user_details_response.dart';
import 'package:vanam_social/data/remote/repository.dart';

class ProfileCubit extends Cubit<ProfileState>{
  Repository _repository = Repository();


  ProfileCubit(ProfileState state) : super(state);


  profileDetails(context) async {
    Map<String,String> map = new Map<String,String>();
    emit(ProfileLoading());
    try {
      UserDetailResponse userDetailResponse =
      await _repository.profileDetails(context,map);
      if(userDetailResponse.success??false){
        await saveUserName("${userDetailResponse.data?.name}");
        await saveUserId("${userDetailResponse.data?.id}");
        await saveMobile("${userDetailResponse.data?.mobileNumber}");
        await saveUserImage("${userDetailResponse.data?.userBasicInfo?.image}");
        emit(ProfileCompleted(userDetailResponse: userDetailResponse));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(ProfileError(error: e.toString()));
      print(e);
    }
  }




  profileUpdateDetails(context,String homeCity,String currentCity,String gender,String language,String intrest,String relationship,String dob) async {
    Map<String,String> map = new Map<String,String>();
    map['home_city'] = homeCity;
    map['current_city'] = currentCity;
    map['gender'] = gender;
    map['language'] = language;
    map['interests'] = intrest;
    map['relationship'] = relationship;
    map['dob'] = dob;
    emit(ProfileUpdateLoading());
    try {
      UserBasicInfoUpdateResponse response =
      await _repository.profileUpdateDetails(context,map);
      if(response.success??false){
        emit(ProfileUpdateCompleted(userBasicInfoUpdateResponse: response));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(ProfileUpdateError(error: e.toString()));
      print(e);
    }
  }

  profileImageUpload(context,List<File> images) async {
    Map<String, String> map = new Map<String, String>();
    emit(ProfileUploadLoading());
    try {
      ProfileUploadResponse response = await _repository.profileUpload(context,map,images);
      if (response.success ?? false) {
        emit(ProfileUploadCompleted(response: response));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(ProfileUploadError(error: e.toString()));
      print(e);
    }
  }


  changePassword(context,String oldPassword,String newPassword,String cPassword) async {
    Map<String, String> map = new Map<String, String>();
    map['old_password'] = oldPassword;
    map['new_password'] = newPassword;
    map['c_password'] = cPassword;
    emit(ProfileChangePasswordLoading());
    try {
      ChangePasswordResponse response = await _repository.changePassword(context,map);
      if (response.success ?? false) {
        emit(ProfileChangePasswordCompleted(response: response));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(ProfileChangePasswordError(error: e.toString()));
      print(e);
    }
  }



}