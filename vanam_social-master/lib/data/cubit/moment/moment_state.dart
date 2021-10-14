import 'package:flutter/foundation.dart';
import 'package:vanam_social/data/remote/model/moment/MomentAddResponse.dart';
import 'package:vanam_social/data/remote/model/moment/MomentListResponse.dart';

@immutable
abstract class MomentState {}

class MomentInitial extends MomentState {}



class MomentError extends MomentState {
  final String error;
  MomentError({required this.error});
}
class MomentLoading extends MomentState {}
class MomentAdded extends MomentState {
  final MomentAddResponse momentAddResponse;
  MomentAdded({required this.momentAddResponse});
}


class MomentListError extends MomentState {
  final String error;
  MomentListError({required this.error});
}
class MomentListLoading extends MomentState {}
class MomentListAdded extends MomentState {
  final MomentListResponse momentListResponse;
  MomentListAdded({required this.momentListResponse});
}
