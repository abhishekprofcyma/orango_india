import 'package:flutter/cupertino.dart';
import 'package:vanam_social/data/remote/model/gallery/GalleryImageResponse.dart';
import 'package:vanam_social/data/remote/model/gallery/GalleryVideoResponse.dart';

@immutable
abstract class GalleryState {}

class GalleryInitial extends GalleryState {}


class GalleryImageLoading extends GalleryState {}
class GalleryImageError extends GalleryState {
  final String error;
  GalleryImageError({required this.error});
}
class GalleryImageCompleted extends GalleryState {
  final GalleryImageResponse response;
  GalleryImageCompleted({required this.response});
}


class GalleryVideoLoading extends GalleryState {}
class GalleryVideoError extends GalleryState {
  final String error;
  GalleryVideoError({required this.error});
}
class GalleryVideoCompleted extends GalleryState {
  final GalleryVideoResponse response;
  GalleryVideoCompleted({required this.response});
}