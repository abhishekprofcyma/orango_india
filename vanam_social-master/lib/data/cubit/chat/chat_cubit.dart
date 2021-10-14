import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vanam_social/data/cubit/chat/chat_state.dart';
import 'package:vanam_social/data/remote/model/chat/chat_file_upload.dart';
import 'package:vanam_social/data/remote/model/chat/message_notification_response.dart';
import 'package:vanam_social/data/remote/repository.dart';

class ChatCubit extends Cubit<ChatState>{
  Repository _repository = Repository();


  ChatCubit(ChatState state) : super(state);



  uploadFile(context,List<File> images) async {
    Map<String,String> map = new Map<String,String>();
    emit(ChatFileUploadLoading());
    try {
      ChatFileUploadResponse chatFileUploadResponse =
      await _repository.chatFileUpload(context,map, images);
      if(chatFileUploadResponse.success){
        emit(ChatFileUploadCompleted(chatFileUploadResponse: chatFileUploadResponse));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(ChatError(error: e.toString()));
      print(e);
    }
  }


  messageNotification(context,String sendto,String message) async {
    Map<String,String> map = Map<String,String>();
    map['send_to'] = sendto;
    map['message'] = message;
    try {
      MessageNotificationResponse messageNotificationResponse =
      await _repository.messageNotification(context,map);
      if(messageNotificationResponse.success??false){

      }
    } catch (e) {
      print("error: ${e.toString()}");
      print(e);
    }
  }

}