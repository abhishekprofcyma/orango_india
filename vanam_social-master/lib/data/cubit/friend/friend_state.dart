import 'package:equatable/equatable.dart';
import 'package:vanam_social/data/remote/model/friend/friend_block_add_response.dart';
import 'package:vanam_social/data/remote/model/friend/friend_block_list_response.dart';
import 'package:vanam_social/data/remote/model/friend/friend_detail_response.dart';
import 'package:vanam_social/data/remote/model/friend/friend_list_response.dart';
import 'package:vanam_social/data/remote/model/friend/un_friend_response.dart';
import 'package:vanam_social/data/remote/model/otp/otp_response.dart';

abstract class FriendState extends Equatable {
  const FriendState();

  @override
  List<Object> get props => [];
}

class FriendInitial extends FriendState {}

class FriendLoading extends FriendState {}

class FriendLoaded extends FriendState {
  final FriendListResponse response;

  FriendLoaded({required this.response});

}

class FriendError extends FriendState {
  final String error;

  FriendError(this.error);
}

class FriendProfileError extends FriendState {
  final String error;
  FriendProfileError({required this.error});
}
class FriendProfileLoading extends FriendState {}
class FriendProfileCompleted extends FriendState {
  final FriendDetailResponse response;
  FriendProfileCompleted({required this.response});
}



class FriendBlockAddLoading extends FriendState{}
class FriendBlockAddError extends FriendState {
  final String error;
  FriendBlockAddError({required this.error});
}
class FriendBlockAddDone extends FriendState {
  final FriendBlockAddResponse response;

  FriendBlockAddDone({required this.response});
}


class FriendBlockListLoading extends FriendState{}
class FriendBlockListError extends FriendState {
  final String error;
  FriendBlockListError({required this.error});
}
class FriendBlockListLoaded extends FriendState {
  final FriendBlockListResponse response;

  FriendBlockListLoaded({required this.response});
}

class FriendUnBlockLoading extends FriendState{}
class FriendUnBlockError extends FriendState {
  final String error;
  FriendUnBlockError({required this.error});
}
class FriendUnBlockDone extends FriendState {
  final FriendBlockAddResponse response;

  FriendUnBlockDone({required this.response});
}

class UnFriendLoading extends FriendState{}
class UnFriendError extends FriendState {
  final String error;
  UnFriendError({required this.error});
}
class UnFriendDone extends FriendState {
  final UnFriendResponse response;

  UnFriendDone({required this.response});
}