import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vanam_social/data/api/ApiProvider.dart';
import 'package:vanam_social/data/remote/model/chat/chat_file_upload.dart';
import 'package:vanam_social/data/remote/model/connection/connection_accept_list_response.dart';
import 'package:vanam_social/data/remote/model/connection/connection_response.dart';
import 'package:vanam_social/data/remote/model/friend/friend_block_add_response.dart';
import 'package:vanam_social/data/remote/model/friend/friend_block_list_response.dart';
import 'package:vanam_social/data/remote/model/friend/un_friend_response.dart';
import 'package:vanam_social/data/remote/model/group/group_create_resopnse.dart';
import 'package:vanam_social/data/remote/model/group/group_details_response.dart';
import 'package:vanam_social/data/remote/model/group/group_image_list_response.dart';
import 'package:vanam_social/data/remote/model/group/group_invite_acccept_list_response.dart';
import 'package:vanam_social/data/remote/model/group/group_invite_add_response.dart';
import 'package:vanam_social/data/remote/model/group/group_invite_list_response.dart';
import 'package:vanam_social/data/remote/model/group/group_join_response.dart';
import 'package:vanam_social/data/remote/model/group/group_joined_list_response.dart';
import 'package:vanam_social/data/remote/model/group/group_list_response.dart';
import 'package:vanam_social/data/remote/model/group/group_member_list_response.dart';
import 'package:vanam_social/data/remote/model/group/group_share_with_response.dart';
import 'package:vanam_social/data/remote/model/group/group_un_join_response.dart';
import 'package:vanam_social/data/remote/model/group/popular_group_response.dart';
import 'package:vanam_social/data/remote/model/login/login_response.dart';
import 'package:vanam_social/data/remote/model/otp/otp_response.dart';
import 'package:vanam_social/data/remote/model/post/PostShareWithResponse.dart';
import 'package:vanam_social/data/remote/model/post/image_like_list_response.dart';
import 'package:vanam_social/data/remote/model/post/post_delete_response.dart';
import 'package:vanam_social/data/remote/model/post/post_share_response.dart';
import 'package:vanam_social/data/remote/model/profile/change_password_response.dart';
import 'package:vanam_social/data/remote/model/register/register_response.dart';

import 'model/chat/message_notification_response.dart';
import 'model/connection/connection_accept_response.dart';
import 'model/connection/connection_deny_response.dart';
import 'model/connection/connetion_request_response.dart';
import 'model/friend/friend_detail_response.dart';
import 'model/friend/friend_list_response.dart';
import 'model/gallery/GalleryImageResponse.dart';
import 'model/gallery/GalleryVideoResponse.dart';
import 'model/moment/MomentAddResponse.dart';
import 'model/moment/MomentListResponse.dart';
import 'model/post/PostCommentListResponse.dart';
import 'model/post/PostCommentResponse.dart';
import 'model/post/PostRecommentResponse.dart';
import 'model/post/post_add_response.dart';
import 'model/post/post_like_response.dart';
import 'model/post/post_list_response.dart';
import 'model/profile/profile_image_update_response.dart';
import 'model/profile/user_basic_info_update_response.dart';
import 'model/profile/user_details_response.dart';
import 'model/reset_password/reset_password_response.dart';
import 'model/vendor/VendorCategoryListResponse.dart';
import 'model/vendor/VendorListResponse.dart';
import 'model/vendor/VendorPlanListResponse.dart';
import 'model/vendor/VendorSubscribeResponse.dart';

class Repository{
  ApiProvider _provider = ApiProvider();

  Future<LoginResponse> fetchLoginDetails(BuildContext context,Map<String,String>map) async {
    final response = await _provider.post(context,"login",map);
    return LoginResponse.fromJson(response);
  }

  Future<RegisterRespnse> fetchRegisterData(BuildContext context,Map<String,String>map) async {
    final response = await _provider.post(context,"register",map);
    return RegisterRespnse.fromJson(response);
  }

  Future<OtpResponse> apiOtpSend(BuildContext context,Map<String,String>map) async {
    final response = await _provider.post(context,"forget-password",map);
    return OtpResponse.fromJson(response);
  }

  Future<ResetPasswordResponse> apiResetPassword(context,Map<String,String>map) async {
    final response = await _provider.post(context,"new-password",map);
    return ResetPasswordResponse.fromJson(response);
  }

  Future<PostListResponse> apiPostList(context,Map<String,String> map) async {
    final response = await _provider.get(context,"post", map);
    return PostListResponse.fromJson(response);
  }

  Future<PostShareResponse> apiPostShare(context,Map<String,String> map) async {
    final response = await _provider.post(context,"share-post", map);
    return PostShareResponse.fromJson(response);
  }

  Future<PostListResponse> apiGroupPostList(context,Map<String,String> map) async {
    final response = await _provider.get(context,"group-post", map);
    return PostListResponse.fromJson(response);
  }

  Future<PostListResponse> apiUserPostList(context,Map<String,String> map) async {
    final response = await _provider.get(context,"user-post", map);
    return PostListResponse.fromJson(response);
  }

  Future<PostLikeResponse> postLike(context,Map<String,String> map) async {
    final response = await _provider.post(context,"post-like", map);
    return PostLikeResponse.fromJson(response);
  }

  Future<PostCommentResponse> postComment(context,Map<String,String> map) async {
    final response = await _provider.post(context,"post-comment", map);
    return PostCommentResponse.fromJson(response);
  }

  Future<PostCommentListResponse> postCommentList(context,Map<String,String> map) async {
    final response = await _provider.get(context,"post-comment", map);
    return PostCommentListResponse.fromJson(response);
  }

  Future<ConnectionResponse> apiConnectionList(context,Map<String,String> map) async {
    final response = await _provider.get(context,"conection", map);
    return ConnectionResponse.fromJson(response);
  }

  Future<ConnectionRequestResponse> apiConnectionRequest(context,Map<String,String> map) async {
    final response = await _provider.post(context,"conection",map);
    return ConnectionRequestResponse.fromJson(response);
  }

  Future<ConnectionAcceptListResponse> apiConnectionAccept(context,Map<String,String> map) async {
    final response = await _provider.get(context,"conection-accept",map);
    return ConnectionAcceptListResponse.fromJson(response);
  }

  Future<ConnectionAcceptResponse> connectionAcceptData(context,Map<String,String> map) async {
    final response = await _provider.post(context,"conection-accept",map);
    return ConnectionAcceptResponse.fromJson(response);
  }

  Future<ConnectionDenyResponse> connectionDenyData(context,Map<String,String> map) async {
    final response = await _provider.post(context,"conection-deny",map);
    return ConnectionDenyResponse.fromJson(response);
  }

  Future<FriendListResponse> fetchFriendsList(context,Map<String,String> map) async {
    final response = await _provider.get(context,"friend",map);
    return FriendListResponse.fromJson(response);
  }

  Future<FriendDetailResponse> friendDetails(context,Map<String,String> map) async {
    final response = await _provider.post(context,"friend-details",map);
    return FriendDetailResponse.fromJson(response);
  }

  Future<ChatFileUploadResponse> chatFileUpload(context,Map<String,String> map,List<File> images) async {
    final response = await _provider.postMultipartFile(context,"message-image", map, images);
    return ChatFileUploadResponse.fromJson(response);
  }

  Future<UserDetailResponse> profileDetails(context,Map<String,String> map) async {
    final response = await _provider.get(context,"user-details",map);
    return UserDetailResponse.fromJson(response);
  }

  Future<UserBasicInfoUpdateResponse> profileUpdateDetails(context,Map<String,String> map) async {
    final response = await _provider.post(context,"user-basicinfo",map);
    return UserBasicInfoUpdateResponse.fromJson(response);
  }

  Future<ProfileUploadResponse> profileUpload(context,Map<String,String>map,List<File>? files) async {
    List<MapEntry<String,MultipartFile>> fileMapEntry = [];
    if(files!.isNotEmpty) {
      fileMapEntry.add(MapEntry("profile",
          await MultipartFile.fromFile(files.first.path, filename: files.first.path
              .split("/")
              .last)));
    }
    final response = await _provider.postMultipartFiles("user-profile",map,fileMapEntry);
    return ProfileUploadResponse.fromJson(response);
  }

  Future<MomentAddResponse> momentsAdd(context,Map<String,String>map,List<File>? files) async {
    List<MapEntry<String,MultipartFile>> fileMapEntry = [];
    if(files!.isNotEmpty) {
      fileMapEntry.add(MapEntry("url",
          await MultipartFile.fromFile(files.first.path, filename: files.first.path
              .split("/")
              .last)));
    }
    final response = await _provider.postMultipartFiles("add-moment",map,fileMapEntry);
    return MomentAddResponse.fromJson(response);
  }

  Future<MomentListResponse> momentList(context,Map<String,String>map) async {
    final response = await _provider.get(context,"add-moment",map);
    return MomentListResponse.fromJson(response);
  }

  Future<PostRecommentResponse> postRecommentAdd(context,Map<String,String> map) async {
    final response = await _provider.post(context,"post-recomment", map);
    return PostRecommentResponse.fromJson(response);
  }

  //post add
  Future<PostAddResponse> postAddWithImages(context,Map<String,String> map,List<File> images) async {
    final response = await _provider.postMultipart(context,"post", map, images);
    return PostAddResponse.fromJson(response);
  }

  Future<PostShareWithResponse> fetchPostShareWithData(context) async {
    var map = Map<String,String>();
    final response = await _provider.get(context,"sharewith",map);
    return PostShareWithResponse.fromJson(response);
  }

  Future<VendorCategoryListResponse> vendorCategoryList(context,Map<String,String> map) async {
    final response = await _provider.get(context,"category",map);
    return VendorCategoryListResponse.fromJson(response);
  }

  Future<VendorListResponse> vendorList(context,Map<String,String> map) async {
    final response = await _provider.get(context,"vendor",map);
    return VendorListResponse.fromJson(response);
  }

  Future<VendorPlanListResponse> vendorPlanList(context,Map<String,String> map) async {
    final response = await _provider.get(context,"vendor-plan",map);
    return VendorPlanListResponse.fromJson(response);
  }

  Future<VendorSubscribeResponse> vendorSubscribe(context,Map<String,String> map) async {
    final response = await _provider.post(context,"vendor-subscribe",map);
    return VendorSubscribeResponse.fromJson(response);
  }

  Future<GalleryImageResponse> galleryImageList(context,Map<String,String> map) async {
    final response = await _provider.get(context,"galery-image",map);
    return GalleryImageResponse.fromJson(response);
  }

  Future<GalleryVideoResponse> galleryVideoList(context,Map<String,String> map) async {
    final response = await _provider.get(context,"galery-video",map);
    return GalleryVideoResponse.fromJson(response);
  }

  Future<ChangePasswordResponse> changePassword(context,Map<String,String> map) async {
    final response = await _provider.post(context,"change-password",map);
    return ChangePasswordResponse.fromJson(response);
  }

  Future<FriendBlockAddResponse> friendBlockAdd(context,Map<String,String> map) async {
    final response = await _provider.post(context,"blocks",map);
    return FriendBlockAddResponse.fromJson(response);
  }

  Future<FriendBlockListResponse> friendBlockList(context,Map<String,String> map) async {
    final response = await _provider.get(context,"blocks",map);
    return FriendBlockListResponse.fromJson(response);
  }

  Future<FriendBlockAddResponse> friendUnBlock(context,Map<String,String> map,int friendId) async {
    final response = await _provider.post(context,"blocks/$friendId",map);
    return FriendBlockAddResponse.fromJson(response);
  }

  Future<PostDeleteResponse> postDelete(context,Map<String,String> map,int postId) async {
    final response = await _provider.delete(context,"post/$postId",map);
    return PostDeleteResponse.fromJson(response);
  }

  Future<UnFriendResponse> unFriend(context,Map<String,String> map,int friendId) async {
    final response = await _provider.delete(context,"friend/$friendId",map);
    return UnFriendResponse.fromJson(response);
  }

  Future<GroupCreateResponse> groupAdd(context,Map<String,String> map,List<File> files) async {
    List<MapEntry<String,MultipartFile>> fileMapEntry = [];
    if(files.isNotEmpty) {
      fileMapEntry.add(MapEntry("image",
          await MultipartFile.fromFile(files.first.path, filename: files.first.path
              .split("/")
              .last)));
    }
    final response = await _provider.postMultipartFiles("group",map,fileMapEntry);
    return GroupCreateResponse.fromJson(response);
  }

  Future<GroupListResponse> groupList(context,Map<String,String> map) async {
    final response = await _provider.get(context,"group",map);
    return GroupListResponse.fromJson(response);
  }

  Future<GroupShareWithResponse> groupShareWith(context) async {
    var map = Map<String,String>();
    final response = await _provider.get(context,"sharewith",map);
    return GroupShareWithResponse.fromJson(response);
  }

  Future<GroupJoinResponse> groupJoin(context,Map<String,String> map) async {
    final response = await _provider.post(context,"group-join",map);
    return GroupJoinResponse.fromJson(response);
  }

  Future<GroupUnJoinResponse> groupUnJoin(context,Map<String,String> map,int groupId) async {
    final response = await _provider.post(context,"group-join/$groupId",map);
    return GroupUnJoinResponse.fromJson(response);
  }

  Future<GroupDetailsResponse> groupDetails(context,Map<String,String> map) async {
    final response = await _provider.post(context,"group-details",map);
    return GroupDetailsResponse.fromJson(response);
  }

  Future<GroupMemberListResponse> groupMembers(context,Map<String,String> map) async {
    final response = await _provider.get(context,"group-join",map);
    return GroupMemberListResponse.fromJson(response);
  }


  Future<GroupInviteListResponse> groupInviteList(context,Map<String,String> map) async {
    final response = await _provider.get(context,"group-invite",map);
    return GroupInviteListResponse.fromJson(response);
  }

  Future<GroupInviteAddResponse> groupInvitationAdd(context,Map<String,String> map) async {
    final response = await _provider.post(context,"group-invite",map);
    return GroupInviteAddResponse.fromJson(response);
  }

  Future<GroupInviteAddResponse> groupInvitationRemove(context,Map<String,String> map,int invitationId) async {
    final response = await _provider.post(context,"group-invite/$invitationId",map);
    return GroupInviteAddResponse.fromJson(response);
  }

  Future<PopularGroupResponse> popularGroupList(context,Map<String,String> map) async {
    final response = await _provider.get(context,"popular-group",map);
    return PopularGroupResponse.fromJson(response);
  }

  Future<MessageNotificationResponse> messageNotification(context,Map<String,String> map) async {
    final response = await _provider.post(context,"message-notification", map);
    return MessageNotificationResponse.fromJson(response);
  }

  Future<ImageLikeListResponse> apiImageLikeList(context,Map<String,String> map) async {
    final response = await _provider.get(context,"post-image", map);
    return ImageLikeListResponse.fromJson(response);
  }

  Future<GroupJoinedListResponse> apiGroupJoinedList(context,Map<String,String> map) async {
    final response = await _provider.get(context,"join-group", map);
    return GroupJoinedListResponse.fromJson(response);
  }

  Future<GroupImageListResponse> apiGroupImageList(context,Map<String,String> map) async {
    final response = await _provider.get(context,"group-image", map);
    return GroupImageListResponse.fromJson(response);
  }

  Future<GroupInviteAccceptListResponse> apiGroupAcceptList(context,Map<String,String> map) async {
    final response = await _provider.get(context,"invite-list", map);
    return GroupInviteAccceptListResponse.fromJson(response);
  }


}