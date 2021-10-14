import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vanam_social/data/cubit/connection/connection_state.dart';
import 'package:vanam_social/data/remote/model/connection/connection_accept_list_response.dart';
import 'package:vanam_social/data/remote/model/connection/connection_accept_response.dart';
import 'package:vanam_social/data/remote/model/connection/connection_deny_response.dart';
import 'package:vanam_social/data/remote/model/connection/connection_response.dart';
import 'package:vanam_social/data/remote/model/connection/connetion_request_response.dart';
import 'package:vanam_social/data/remote/repository.dart';


class ConnectionCubit extends Cubit<ConnectionsState>{
  Repository _repository = Repository();


  ConnectionCubit(ConnectionsState state) : super(state);


  connectionList(BuildContext context,int page) async {
    var map = Map<String,String>();
    map['page'] = "${page}";
    emit(ConnectionLoading());
    try {
      ConnectionResponse response =
      await _repository.apiConnectionList(context,map);
      if(response.success!){
        emit(ConnectionLoaded(response: response));
      }else{
        Fluttertoast.showToast(msg: "Connection failed to send");
      }
    } catch (e) {
      print("error: ${e.toString()}");
      Fluttertoast.showToast(msg: "Connection failed to send");
      emit(ConnectionError("otp failed to send"));
      print(e);
    }
  }

  connectionReqSend(context,int friendId) async {
    var map = Map<String,String>();
    map['friend_id'] = friendId.toString();
    emit(ConnectionRequestLoading());
    try {
      ConnectionRequestResponse connectionRequestResponse =
      await _repository.apiConnectionRequest(context,map);
      if(connectionRequestResponse.success!){
        emit(ConnectionRequestLoaded(response: connectionRequestResponse));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(ConnectionRequestError(e.toString()));
      print(e);
    }
  }

  connectionAcceptList(context,int page) async {
    Map<String,String> map = new Map<String,String>();
    map['page'] = "$page";
    emit(ConnectionAcceptListLoading());
    try {
      ConnectionAcceptListResponse connectionAcceptListResponse =
      await _repository.apiConnectionAccept(context,map);
      if(connectionAcceptListResponse.success!){
        emit(ConnectionAcceptListLoaded(response: connectionAcceptListResponse));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(ConnectionAcceptListError(e.toString()));
      print(e);
    }
  }

  connectionAccept(context,int id) async {
    Map<String,String> map = new Map<String,String>();
    map['connect_id'] = id.toString();
    emit(ConnectionAcceptLoading());
    try {
      ConnectionAcceptResponse connectionAcceptResponse =
      await _repository.connectionAcceptData(context,map);
      if(connectionAcceptResponse.success!){
        emit(ConnectionAcceptLoaded(response: connectionAcceptResponse));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(ConnectionAcceptError(e.toString()));
      print(e);
    }
  }


  connectionDeny(context,int id) async {
    Map<String,String> map = new Map<String,String>();
    map['connect_id'] = id.toString();
    emit(ConnectionDenyLoading());
    try {
      ConnectionDenyResponse response =
      await _repository.connectionDenyData(context,map);
      if(response.success!){
        emit(ConnectionDenyLoaded(response: response));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(ConnectionDenyError(e.toString()));
      print(e);
    }
  }



}