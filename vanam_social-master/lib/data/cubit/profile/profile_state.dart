
import 'package:flutter/foundation.dart';
import 'package:vanam_social/data/remote/model/post/post_list_response.dart';
import 'package:vanam_social/data/remote/model/profile/change_password_response.dart';
import 'package:vanam_social/data/remote/model/profile/profile_image_update_response.dart';
import 'package:vanam_social/data/remote/model/profile/user_basic_info_update_response.dart';
import 'package:vanam_social/data/remote/model/profile/user_details_response.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}
class ProfileLoading extends ProfileState {}
class ProfileError extends ProfileState {
  final String error;
  ProfileError({required this.error});
}
class ProfileCompleted extends ProfileState {
  final UserDetailResponse userDetailResponse;
  ProfileCompleted({required this.userDetailResponse});
}




class ProfilePostLoading extends ProfileState {}
class ProfilePostError extends ProfileState {
  final String error;
  ProfilePostError({required this.error});
}
class ProfilePostListCompleted extends ProfileState {
  final PostListResponse postListResponse;

  ProfilePostListCompleted({required this.postListResponse});
}



class ProfileUpdateLoading extends ProfileState {}
class ProfileUpdateError extends ProfileState {
  final String error;
  ProfileUpdateError({required this.error});
}
class ProfileUpdateCompleted extends ProfileState {
  final UserBasicInfoUpdateResponse userBasicInfoUpdateResponse;
  ProfileUpdateCompleted({required this.userBasicInfoUpdateResponse});
}


class ProfileUploadLoading extends ProfileState {}
class ProfileUploadError extends ProfileState {
  final String error;
  ProfileUploadError({required this.error});
}
class ProfileUploadCompleted extends ProfileState {
  final ProfileUploadResponse response;

  ProfileUploadCompleted({required this.response});
}


class ProfileChangePasswordLoading extends ProfileState{}
class ProfileChangePasswordError extends ProfileState {
  final String error;
  ProfileChangePasswordError({required this.error});
}
class ProfileChangePasswordCompleted extends ProfileState {
  final ChangePasswordResponse response;

  ProfileChangePasswordCompleted({required this.response});
}
