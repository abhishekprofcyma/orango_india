import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vanam_social/data/cubit/otp/otp_state.dart';
import 'package:vanam_social/data/cubit/post_list/post_list_state.dart';
import 'package:vanam_social/data/remote/model/otp/otp_response.dart';
import 'package:vanam_social/data/remote/model/post/PostCommentListResponse.dart';
import 'package:vanam_social/data/remote/model/post/PostCommentResponse.dart';
import 'package:vanam_social/data/remote/model/post/PostRecommentResponse.dart';
import 'package:vanam_social/data/remote/model/post/PostShareWithResponse.dart';
import 'package:vanam_social/data/remote/model/post/image_like_list_response.dart';
import 'package:vanam_social/data/remote/model/post/post_add_response.dart';
import 'package:vanam_social/data/remote/model/post/post_delete_response.dart';
import 'package:vanam_social/data/remote/model/post/post_like_response.dart';
import 'package:vanam_social/data/remote/model/post/post_list_response.dart';
import 'package:vanam_social/data/remote/model/post/post_share_response.dart';
import 'package:vanam_social/data/remote/repository.dart';

class PostListCubit extends Cubit<PostListState>{
  Repository _repository = Repository();


  PostListCubit(PostListState state) : super(state);


  postList(BuildContext context,int page,int groupId) async {
    var map = Map<String,String>();
    map['page'] = "$page";
    map['group_id'] = "$groupId";
    emit(PostListLoading());
    try {
      PostListResponse response =
      await _repository.apiPostList(context,map);
      if(response.success!){
        print("post list count ${response.data?.postList?.data?.length}");
        emit(PostListLoaded(response: response));
      }else{
        Fluttertoast.showToast(msg: "PostList failed to load");
      }
    } catch (e) {
      print("error: ${e.toString()}");
      Fluttertoast.showToast(msg: "PostList failed to load");
      emit(PostListError("Post list failed"));
      print(e);
    }
  }


  groupPostList(BuildContext context,int page,int groupId) async {
    var map = Map<String,String>();
    map['page'] = "$page";
    map['group_id'] = "$groupId";
    emit(PostListLoading());
    try {
      PostListResponse response =
      await _repository.apiGroupPostList(context,map);
      if(response.success!){
        emit(PostListLoaded(response: response));
      }else{
        Fluttertoast.showToast(msg: "PostList failed to load");
      }
    } catch (e) {
      print("error: ${e.toString()}");
      Fluttertoast.showToast(msg: "PostList failed to load");
      emit(PostListError("Post list failed"));
      print(e);
    }
  }

  userPostList(context,int pageNo,String friendId) async {
    Map<String, String> map = new Map<String, String>();
    map['page'] = pageNo.toString();
    map['friend_id'] = friendId;
    emit(PostListLoading());
    try {
      PostListResponse postListResponse = await _repository.apiUserPostList(context,map);
      if (postListResponse.success!) {
        print("post list count ${postListResponse.data?.postList?.data?.length}");
        emit(PostListLoaded(response: postListResponse));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(PostListError("Post list failed"));
      print(e);
    }
  }


  postLike(context,String postId, String like) async {
    Map<String, String> map = new Map<String, String>();
    map['post_id'] = postId;
    map['like'] = like;
    emit(PostLikeLoading());
    try {
      PostLikeResponse postLikeResponse = await _repository.postLike(context,map);
      if (postLikeResponse.success??false) {
        if (like == "1") {
          emit(PostLiked(postLikeResponse: postLikeResponse));
        } else {
          emit(PostUnLiked(postLikeResponse: postLikeResponse));
        }
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(PostLikeError(error: e.toString()));
      print(e);
    }
  }

  fetchComment(context,String postId, String comment) async {
    Map<String, String> map = new Map<String, String>();
    map['post_id'] = postId;
    map['comment'] = comment;
    emit(PostCommentLoading());
    try {
      PostCommentResponse postCommentResponse =
      await _repository.postComment(context,map);
      if (postCommentResponse.success) {
        emit(PostCommentCompleted(postCommentResponse: postCommentResponse));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(PostError(error: e.toString()));
      print(e);
    }
  }

  fetchCommentList(context,int postId, int page) async {
    Map<String, String> map = new Map<String, String>();
    map['post_id'] = postId.toString();
    map['page'] = page.toString();
    emit(PostCommentListLoading());
    try {
      PostCommentListResponse postCommentListResponse =
      await _repository.postCommentList(context,map);
      if (postCommentListResponse.success??false) {
        emit(PostCommentListCompleted(
            postCommentListResponse: postCommentListResponse));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(PostError(error: e.toString()));
      print(e);
    }
  }

  postRecommentAdd(context,String postId, String commentId, String comment) async {
    Map<String, String> map = new Map<String, String>();
    map['post_id'] = postId;
    map['post_comment_id'] = commentId;
    map['comment'] = comment;
    emit(PostRecommentAddLoading());
    try {
      PostRecommentResponse postRecommentResponse =
      await _repository.postRecommentAdd(context,map);
      if (postRecommentResponse.success??false) {
        emit(PostRecommentAdded(postRecommentResponse: postRecommentResponse));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(PostRecommentAddError(error: e.toString()));
      print(e);
    }
  }

  //post share
  fetchPostWithImageAdd(context,
      String shareId, String content, List<File> images,String groupId) async {
    Map<String, String> map = new Map<String, String>();
    map['share_id'] = shareId;
    map['content'] = content;
    map['group_id'] = groupId.toString();
    emit(PostListLoading());
    try {
      PostAddResponse postAddResponse =
      await _repository.postAddWithImages(context,map, images);
      if (postAddResponse.success) {
        emit(PostCompleted(postAddResponse: postAddResponse));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(PostError(error: e.toString()));
      print(e);
    }
  }

  fetchPostWithList(context) async {
    emit(PostShareWithLoading());
    Map<String, String> map = new Map<String, String>();
    try {
      PostShareWithResponse postShareWithResponse =
      await _repository.fetchPostShareWithData(context);
      if (postShareWithResponse.success ?? false) {
        emit(
            PostShareWithCompleted(postCommentResponse: postShareWithResponse));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(PostError(error: e.toString()));
      print(e);
    }
  }

  postDelete(context,int postId) async {
    emit(PostDeleteLoading());
    Map<String, String> map = new Map<String, String>();
    try {
      PostDeleteResponse response =
      await _repository.postDelete(context,map,postId);
      if (response.success ?? false) {
        emit(
            PostDeleted(response: response));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(PostDeleteError(error: e.toString()));
      print(e);
    }
  }


  postShareAdd(context,int shareTo,int postId, int shareId, String content) async {
    Map<String, String> map = new Map<String, String>();
    map['share_to'] = shareTo.toString();
    map['post_id'] = postId.toString();
    map['share_id'] = shareId.toString();
    map['content'] = content;
    emit(PostShareLoading());
    try {
      PostShareResponse response =
      await _repository.apiPostShare(context,map);
      if (response.success??false) {
        emit(PostShareAdded(response: response));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(PostShareError(error: e.toString()));
      print(e);
    }
  }


  imageLikeList(context) async {
    Map<String, String> map = new Map<String, String>();
    emit(PostLikeLoading());
    try {
      ImageLikeListResponse response =
      await _repository.apiImageLikeList(context,map);
      if (response.success??false) {
        emit(PostLikeListAdded(response: response));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(PostLikeListError(error: e.toString()));
      print(e);
    }
  }

}