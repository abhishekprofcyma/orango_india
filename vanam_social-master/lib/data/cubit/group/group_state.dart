import 'package:flutter/foundation.dart';
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

@immutable
abstract class GroupState {}

class GroupInitial extends GroupState {}



class GroupError extends GroupState {
  final String error;
  GroupError({required this.error});
}
class GroupLoading extends GroupState {}
class GroupAdded extends GroupState {
  final GroupCreateResponse response;
  GroupAdded({required this.response});
}


class GroupListError extends GroupState {
  final String error;
  GroupListError({required this.error});
}
class GroupListLoading extends GroupState {}
class GroupListAdded extends GroupState {
  final GroupListResponse response;
  GroupListAdded({required this.response});
}


class GroupShareWithError extends GroupState {
  final String error;
  GroupShareWithError({required this.error});
}
class GroupShareWithLoading extends GroupState {}
class GroupShareWithLoaded extends GroupState {
  final GroupShareWithResponse response;
  GroupShareWithLoaded({required this.response});
}


class GroupJoinError extends GroupState {
  final String error;
  GroupJoinError({required this.error});
}
class GroupJoinLoading extends GroupState {}
class GroupJoined extends GroupState {
  final GroupJoinResponse response;
  GroupJoined({required this.response});
}


class GroupUnJoinError extends GroupState {
  final String error;
  GroupUnJoinError({required this.error});
}
class GroupUnJoinLoading extends GroupState {}
class GroupUnJoined extends GroupState {
  final GroupUnJoinResponse response;
  GroupUnJoined({required this.response});
}


class GroupDetailError extends GroupState {
  final String error;
  GroupDetailError({required this.error});
}
class GroupDetailLoading extends GroupState {}
class GroupDetailLoaded extends GroupState {
  final GroupDetailsResponse response;
  GroupDetailLoaded({required this.response});
}


class GroupMemberListError extends GroupState {
  final String error;
  GroupMemberListError({required this.error});
}
class GroupMemberListLoading extends GroupState {}
class GroupMemberListLoaded extends GroupState {
  final GroupMemberListResponse response;
  GroupMemberListLoaded({required this.response});
}


class GroupInviteListError extends GroupState {
  final String error;
  GroupInviteListError({required this.error});
}
class GroupInviteListLoading extends GroupState {}
class GroupInviteListLoaded extends GroupState {
  final GroupInviteListResponse response;
  GroupInviteListLoaded({required this.response});
}


class GroupInviteAddError extends GroupState {
  final String error;
  GroupInviteAddError({required this.error});
}
class GroupInviteAddLoading extends GroupState {}
class GroupInviteAddLoaded extends GroupState {
  final GroupInviteAddResponse response;
  GroupInviteAddLoaded({required this.response});
}


class GroupInviteRemoveError extends GroupState {
  final String error;
  GroupInviteRemoveError({required this.error});
}
class GroupInviteRemoveLoading extends GroupState {}
class GroupInviteRemoveLoaded extends GroupState {
  final GroupInviteAddResponse response;
  GroupInviteRemoveLoaded({required this.response});
}


class GroupPopularListError extends GroupState {
  final String error;
  GroupPopularListError({required this.error});
}
class GroupPopularListLoading extends GroupState {}
class GroupPopularListAdded extends GroupState {
  final PopularGroupResponse response;
  GroupPopularListAdded({required this.response});
}


class GroupJoinedListError extends GroupState {
  final String error;
  GroupJoinedListError({required this.error});
}
class GroupJoinedListLoading extends GroupState {}
class GroupJoinedListAdded extends GroupState {
  final GroupJoinedListResponse response;
  GroupJoinedListAdded({required this.response});
}


class GroupImageListError extends GroupState {
  final String error;
  GroupImageListError({required this.error});
}
class GroupImageListLoading extends GroupState {}
class GroupImageListAdded extends GroupState {
  final GroupImageListResponse response;
  GroupImageListAdded({required this.response});
}


class GroupInviteAcceptError extends GroupState {
  final String error;
  GroupInviteAcceptError({required this.error});
}
class GroupInviteAcceptLoading extends GroupState {}
class GroupInviteAcceptAdded extends GroupState {
  final GroupInviteAccceptListResponse response;
  GroupInviteAcceptAdded({required this.response});
}