import 'package:flutter/foundation.dart';
import 'package:vanam_social/data/remote/model/vendor/VendorCategoryListResponse.dart';
import 'package:vanam_social/data/remote/model/vendor/VendorListResponse.dart';
import 'package:vanam_social/data/remote/model/vendor/VendorPlanListResponse.dart';
import 'package:vanam_social/data/remote/model/vendor/VendorSubscribeResponse.dart';

@immutable
abstract class VendorState {}

class VendorInitial extends VendorState {}



class VendorCategoryLoading extends VendorState {}
class VendorCategoryError extends VendorState {
  final String error;
  VendorCategoryError({required this.error});
}
class VendorCategoryLoaded extends VendorState {
  final VendorCategoryListResponse response;
  VendorCategoryLoaded({required this.response});
}



class VendorListLoading extends VendorState {}
class VendorListError extends VendorState {
  final String error;
  VendorListError({required this.error});
}
class VendorListLoaded extends VendorState {
  final VendorListResponse response;
  VendorListLoaded({required this.response});
}


class VendorPlanListLoading extends VendorState {}
class VendorPlanListError extends VendorState {
  final String error;
  VendorPlanListError({required this.error});
}
class VendorPlanListLoaded extends VendorState {
  final VendorPlanListResponse response;
  VendorPlanListLoaded({required this.response});
}



class VendorSubscribeLoading extends VendorState {}
class VendorSubscribeError extends VendorState {
  final String error;
  VendorSubscribeError({required this.error});
}
class VendorSubscribeLoaded extends VendorState {
  final VendorSubscribeResponse response;
  VendorSubscribeLoaded({required this.response});
}