import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vanam_social/data/cubit/friend/friend_state.dart';
import 'package:vanam_social/data/cubit/otp/otp_state.dart';
import 'package:vanam_social/data/remote/model/friend/friend_block_add_response.dart';
import 'package:vanam_social/data/remote/model/friend/friend_block_list_response.dart';
import 'package:vanam_social/data/remote/model/friend/friend_detail_response.dart';
import 'package:vanam_social/data/remote/model/friend/friend_list_response.dart';
import 'package:vanam_social/data/remote/model/friend/un_friend_response.dart';
import 'package:vanam_social/data/remote/model/otp/otp_response.dart';
import 'package:vanam_social/data/remote/repository.dart';

class FriendCubit extends Cubit<FriendState>{
  Repository _repository = Repository();


  FriendCubit(FriendState state) : super(state);


  friendList(BuildContext context,int page) async {
    var map = Map<String,String>();
    emit(FriendLoading());
    try {
      FriendListResponse response =
      await _repository.fetchFriendsList(context,map);
      if(response.success!){
        emit(FriendLoaded(response: response));
      }else{
        Fluttertoast.showToast(msg: "Friend failed to load");
      }
    } catch (e) {
      print("error: ${e.toString()}");
      Fluttertoast.showToast(msg: "Friend failed to load");
      emit(FriendError("otp failed to load"));
      print(e);
    }
  }

  friendDetails(context,int friendId) async {
    Map<String,String> map = new Map<String,String>();
    map['friend_id'] = "$friendId";
    emit(FriendProfileLoading());
    try {
      FriendDetailResponse response =
      await _repository.friendDetails(context,map);
      if(response.success!){
        emit(FriendProfileCompleted(response: response));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(FriendProfileError(error: e.toString()));
      print(e);
    }
  }

  friendBlock(context,int friendId) async {
    Map<String,String> map = new Map<String,String>();
    map['friend_id'] = "$friendId";
    emit(FriendBlockAddLoading());
    try {
      FriendBlockAddResponse response =
      await _repository.friendBlockAdd(context,map);
      if(response.success!){
        emit(FriendBlockAddDone(response: response));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(FriendBlockAddError(error: e.toString()));
      print(e);
    }
  }

  friendBlockList(context,int page) async {
    Map<String,String> map = new Map<String,String>();
    map['page'] = page.toString();
    emit(FriendBlockListLoading());
    try {
      FriendBlockListResponse response =
      await _repository.friendBlockList(context,map);
      if(response.success!){
        emit(FriendBlockListLoaded(response: response));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(FriendBlockListError(error: e.toString()));
      print(e);
    }
  }

  friendUnBlock(context,int friendId) async {
    Map<String,String> map = new Map<String,String>();
    map['friend_id'] = "$friendId";
    map['_method'] = "put";
    emit(FriendUnBlockLoading());
    try {
      FriendBlockAddResponse response =
      await _repository.friendUnBlock(context,map,friendId);
      if(response.success!){
        emit(FriendUnBlockDone(response: response));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(FriendUnBlockError(error: e.toString()));
      print(e);
    }
  }

  unFriend(context,int friendId) async {
    Map<String,String> map = new Map<String,String>();
    map['friend_id'] = "$friendId";
    emit(UnFriendLoading());
    try {
      UnFriendResponse response =
      await _repository.unFriend(context,map,friendId);
      if(response.success!){
        emit(UnFriendDone(response: response));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(UnFriendError(error: e.toString()));
      print(e);
    }
  }




}