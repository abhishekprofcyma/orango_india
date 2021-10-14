import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanam_social/data/cubit/group/group_state.dart';
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
import 'package:vanam_social/data/remote/repository.dart';

class GroupCubit extends Cubit<GroupState>{
  Repository _repository = Repository();
  GroupCubit(GroupState initialState) : super(initialState);


  groupAdd(context,String name,int shareId,List<File> images) async {
    Map<String, String> map = new Map<String, String>();
    map['name'] = name;
    map['share_id'] = shareId.toString();
    emit(GroupLoading());
    try {
      GroupCreateResponse response =
      await _repository.groupAdd(context,map, images);
      if (response.success??false) {
        emit(GroupAdded(response: response));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(GroupError(error: e.toString()));
      print(e);
    }
  }

  fetchGroupShareWith(context) async {
    emit(GroupShareWithLoading());
    Map<String, String> map = new Map<String, String>();
    try {
      GroupShareWithResponse response =
      await _repository.groupShareWith(context);
      if (response.success ?? false) {
        emit(
            GroupShareWithLoaded(response: response));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(GroupShareWithError(error: e.toString()));
      print(e);
    }
  }

  groupList(context,int page) async {
    Map<String, String> map = new Map<String, String>();
    map['page'] = page.toString();
    emit(GroupListLoading());
    try {
      GroupListResponse response =
      await _repository.groupList(context,map);
      if (response.success??false) {
        emit(GroupListAdded(response: response));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(GroupListError(error: e.toString()));
      print(e);
    }
  }

  groupJoin(context,int groupId) async {
    Map<String, String> map = new Map<String, String>();
    map['group_id'] = groupId.toString();
    emit(GroupJoinLoading());
    try {
      GroupJoinResponse response =
      await _repository.groupJoin(context,map);
      if (response.success??false) {
        emit(GroupJoined(response: response));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(GroupJoinError(error: e.toString()));
      print(e);
    }
  }

  groupUnJoin(context,int groupId) async {
    Map<String, String> map = new Map<String, String>();
    map['group_id'] = groupId.toString();
    map['_method'] = "put";
    emit(GroupUnJoinLoading());
    try {
      GroupUnJoinResponse response =
      await _repository.groupUnJoin(context,map,groupId);
      if (response.success??false) {
        emit(GroupUnJoined(response: response));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(GroupUnJoinError(error: e.toString()));
      print(e);
    }
  }

  groupDetails(context,int groupId) async {
    Map<String, String> map = new Map<String, String>();
    map['group_id'] = groupId.toString();
    emit(GroupDetailLoading());
    try {
      GroupDetailsResponse response =
      await _repository.groupDetails(context,map);
      if (response.success??false) {
        emit(GroupDetailLoaded(response: response));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(GroupDetailError(error: e.toString()));
      print(e);
    }
  }

  groupMembers(context,int page,int groupId) async {
    Map<String, String> map = new Map<String, String>();
    map['page'] = page.toString();
    map['group_id'] = groupId.toString();
    emit(GroupMemberListLoading());
    try {
      GroupMemberListResponse response =
      await _repository.groupMembers(context,map);
      if (response.success??false) {
        emit(GroupMemberListLoaded(response: response));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(GroupMemberListError(error: e.toString()));
      print(e);
    }
  }

  groupInviteList(context,int page,int groupId) async {
    Map<String, String> map = new Map<String, String>();
    map['page'] = page.toString();
    map['group_id'] = groupId.toString();
    emit(GroupInviteListLoading());
    try {
      GroupInviteListResponse response =
      await _repository.groupInviteList(context,map);
      if (response.success??false) {
        emit(GroupInviteListLoaded(response: response));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(GroupInviteListError(error: e.toString()));
      print(e);
    }
  }

  groupInvitationAdd(context,int groupId,int userId) async {
    Map<String, String> map = new Map<String, String>();
    map['group_id'] = groupId.toString();
    map['user_id'] = userId.toString();
    emit(GroupInviteAddLoading());
    try {
      GroupInviteAddResponse response =
      await _repository.groupInvitationAdd(context,map);
      if (response.success??false) {
        emit(GroupInviteAddLoaded(response: response));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(GroupInviteAddError(error: e.toString()));
      print(e);
    }
  }

  groupInvitationRemove(context,int groupId,int userId,int invitationId) async {
    Map<String, String> map = new Map<String, String>();
    map['group_id'] = groupId.toString();
    map['user_id'] = userId.toString();
    map['_method'] = "put";
    emit(GroupInviteRemoveLoading());
    try {
      GroupInviteAddResponse response =
      await _repository.groupInvitationRemove(context,map,invitationId);
      if (response.success??false) {
        emit(GroupInviteRemoveLoaded(response: response));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(GroupInviteRemoveError(error: e.toString()));
      print(e);
    }
  }

  popularGroupList(context,int page) async {
    Map<String, String> map = new Map<String, String>();
    map['page'] = page.toString();
    emit(GroupPopularListLoading());
    try {
      PopularGroupResponse response =
      await _repository.popularGroupList(context,map);
      if (response.success??false) {
        emit(GroupPopularListAdded(response: response));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(GroupPopularListError(error: e.toString()));
      print(e);
    }
  }

  groupJoinedList(context,int page) async {
    Map<String, String> map = new Map<String, String>();
    map['page'] = page.toString();
    emit(GroupJoinedListLoading());
    try {
      GroupJoinedListResponse response =
      await _repository.apiGroupJoinedList(context,map);
      if (response.success??false) {
        emit(GroupJoinedListAdded(response: response));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(GroupJoinedListError(error: e.toString()));
      print(e);
    }
  }

  groupImageList(context,int page,int groupId) async {
    Map<String, String> map = new Map<String, String>();
    map['page'] = page.toString();
    map['group_id'] = groupId.toString();
    emit(GroupImageListLoading());
    try {
      GroupImageListResponse response =
      await _repository.apiGroupImageList(context,map);
      if (response.success??false) {
        emit(GroupImageListAdded(response: response));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(GroupImageListError(error: e.toString()));
      print(e);
    }
  }

  groupInviteAcceptList(context,int page) async {
    Map<String, String> map = new Map<String, String>();
    map['page'] = page.toString();
    emit(GroupInviteAcceptLoading());
    try {
      GroupInviteAccceptListResponse response =
      await _repository.apiGroupAcceptList(context,map);
      if (response.success??false) {
        emit(GroupInviteAcceptAdded(response: response));
      }
    } catch (e) {
      print("error: ${e.toString()}");
      emit(GroupInviteAcceptError(error: e.toString()));
      print(e);
    }
  }

}