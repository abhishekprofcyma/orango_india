import 'package:equatable/equatable.dart';
import 'package:vanam_social/data/remote/model/otp/otp_response.dart';
import 'package:vanam_social/data/remote/model/post/PostCommentListResponse.dart';
import 'package:vanam_social/data/remote/model/post/PostCommentResponse.dart';
import 'package:vanam_social/data/remote/model/post/PostFavouriteResponse.dart';
import 'package:vanam_social/data/remote/model/post/PostRecommentResponse.dart';
import 'package:vanam_social/data/remote/model/post/PostShareWithResponse.dart';
import 'package:vanam_social/data/remote/model/post/image_like_list_response.dart';
import 'package:vanam_social/data/remote/model/post/post_add_response.dart';
import 'package:vanam_social/data/remote/model/post/post_delete_response.dart';
import 'package:vanam_social/data/remote/model/post/post_like_response.dart';
import 'package:vanam_social/data/remote/model/post/post_list_response.dart';
import 'package:vanam_social/data/remote/model/post/post_share_response.dart';

abstract class PostListState extends Equatable {
  const PostListState();

  @override
  List<Object> get props => [];
}

class PostListInitial extends PostListState {}
class PostCompleted extends PostListState {
  final PostAddResponse postAddResponse;

  PostCompleted({required this.postAddResponse});
}
class PostError extends PostListState {
  final String error;

  PostError({required this.error});
}

class PostListLoading extends PostListState {}

class PostListLoaded extends PostListState {
  final PostListResponse response;

  PostListLoaded({required this.response});

}

class PostListError extends PostListState {
  final String error;

  PostListError(this.error);
}



class PostLikeLoading extends PostListState {}
class PostLikeError extends PostListState {
  final String error;
  PostLikeError({required this.error});
}
class PostLiked extends PostListState {
  final PostLikeResponse postLikeResponse;
  PostLiked({required this.postLikeResponse});
}

class PostUnLiked extends PostListState {
  final PostLikeResponse postLikeResponse;
  PostUnLiked({required this.postLikeResponse});
}




class PostCommentLoading extends PostListState {}
class PostCommentCompleted extends PostListState {
  final PostCommentResponse postCommentResponse;
  PostCommentCompleted({required this.postCommentResponse});
}

class PostCommentListLoading extends PostListState {}
class PostCommentListCompleted extends PostListState {
  final PostCommentListResponse postCommentListResponse;
  PostCommentListCompleted({required this.postCommentListResponse});
}
class PostShareWithLoading extends PostListState {}
class PostShareWithCompleted extends PostListState {
  final PostShareWithResponse postCommentResponse;
  PostShareWithCompleted({required this.postCommentResponse});
}






class PostFavouriteLoading extends PostListState {}
class PostFavouriteError extends PostListState {
  final String error;
  PostFavouriteError({required this.error});
}
class PostFavourite extends PostListState {
  final PostFavouriteResponse postFavouriteResponse;
  PostFavourite({required this.postFavouriteResponse});
}
class PostUnFavourite extends PostListState {
  final PostFavouriteResponse postFavouriteResponse;
  PostUnFavourite({required this.postFavouriteResponse});
}

class PostRecommentAddLoading extends PostListState {}
class PostRecommentAddError extends PostListState {
  final String error;
  PostRecommentAddError({required this.error});
}
class PostRecommentAdded extends PostListState {
  final PostRecommentResponse postRecommentResponse;
  PostRecommentAdded({required this.postRecommentResponse});
}


class PostDeleteLoading extends PostListState{}
class PostDeleteError extends PostListState {
  final String error;
  PostDeleteError({required this.error});
}
class PostDeleted extends PostListState {
  final PostDeleteResponse response;

  PostDeleted({required this.response});
}


class PostShareLoading extends PostListState {}
class PostShareError extends PostListState {
  final String error;
  PostShareError({required this.error});
}
class PostShareAdded extends PostListState {
  final PostShareResponse response;
  PostShareAdded({required this.response});
}


class PostLikeListLoading extends PostListState {}
class PostLikeListError extends PostListState {
  final String error;
  PostLikeListError({required this.error});
}
class PostLikeListAdded extends PostListState {
  final ImageLikeListResponse response;
  PostLikeListAdded({required this.response});
}
