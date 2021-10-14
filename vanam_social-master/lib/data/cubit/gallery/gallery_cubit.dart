
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanam_social/data/remote/model/gallery/GalleryImageResponse.dart';
import 'package:vanam_social/data/remote/model/gallery/GalleryVideoResponse.dart';
import 'package:vanam_social/data/remote/repository.dart';

import 'gallery_state.dart';

class GalleryCubit extends Cubit<GalleryState>{

  Repository _repository = Repository();

  GalleryCubit(GalleryState initialState) : super(initialState);

  galleryImage(context,int friendId) async {
    Map<String,String> map = new Map<String,String>();
    map['friend_id'] = friendId.toString();
    emit(GalleryImageLoading());
    try {
      GalleryImageResponse response =
      await _repository.galleryImageList(context,map);
      if(response.success??false){
        emit(GalleryImageCompleted(response: response));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(GalleryImageError(error: e.toString()));
      print(e);
    }
  }


  galleryVideo(context,int friendId) async {
    Map<String,String> map = new Map<String,String>();
    map['friend_id'] = friendId.toString();
    emit(GalleryVideoLoading());
    try {
      GalleryVideoResponse response =
      await _repository.galleryVideoList(context,map);
      if(response.success??false){
        emit(GalleryVideoCompleted(response: response));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(GalleryVideoError(error: e.toString()));
      print(e);
    }
  }

}