import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanam_social/data/cubit/moment/moment_state.dart';
import 'package:vanam_social/data/remote/model/moment/MomentAddResponse.dart';
import 'package:vanam_social/data/remote/model/moment/MomentListResponse.dart';
import 'package:vanam_social/data/remote/repository.dart';

class MomentCubit extends Cubit<MomentState>{
  Repository _repository = Repository();
  MomentCubit(MomentState initialState) : super(initialState);


  momentAdd(context,List<File> images) async {
    Map<String, String> map = new Map<String, String>();
    emit(MomentLoading());
    try {
      MomentAddResponse momentAddResponse =
      await _repository.momentsAdd(context,map, images);
      if (momentAddResponse.success??false) {
        emit(MomentAdded(momentAddResponse: momentAddResponse));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(MomentError(error: e.toString()));
      print(e);
    }
  }


  momentList(context) async {
    Map<String, String> map = new Map<String, String>();
    emit(MomentListLoading());
    try {
      MomentListResponse response =
      await _repository.momentList(context,map);
      if (response.success??false) {
        emit(MomentListAdded(momentListResponse: response));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(MomentListError(error: e.toString()));
      print(e);
    }
  }

}