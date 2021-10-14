import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanam_social/data/cubit/vendor/VendorState.dart';
import 'package:vanam_social/data/remote/model/vendor/VendorCategoryListResponse.dart';
import 'package:vanam_social/data/remote/model/vendor/VendorListResponse.dart';
import 'package:vanam_social/data/remote/model/vendor/VendorPlanListResponse.dart';
import 'package:vanam_social/data/remote/model/vendor/VendorSubscribeResponse.dart';
import 'package:vanam_social/data/remote/repository.dart';

class VendorCubit extends Cubit<VendorState>{
  Repository _repository = Repository();

  VendorCubit(initialState) : super(initialState);


  vendorCategory(context) async {
    var map = Map<String,String>();
    emit(VendorCategoryLoading());
    try {
      VendorCategoryListResponse response =
      await _repository.vendorCategoryList(context,map);
      emit(VendorCategoryLoaded(response: response));
    } catch (e) {
      print("error: ${e.toString()}");
      emit(VendorCategoryError(error: e.toString()));
      print(e);
    }
  }


  vendorList(context,int categoryId) async {
    var map = Map<String,String>();
    map['category_id'] = categoryId.toString();
    emit(VendorListLoading());
    try {
      VendorListResponse response =
      await _repository.vendorList(context,map);
      emit(VendorListLoaded(response: response));
    } catch (e) {
      print("error: ${e.toString()}");
      emit(VendorListError(error: e.toString()));
      print(e);
    }
  }


  vendorPlanList(context,int vendorId) async {
    var map = Map<String,String>();
    map['vendor_id'] = vendorId.toString();
    emit(VendorPlanListLoading());
    try {
      VendorPlanListResponse response =
      await _repository.vendorPlanList(context,map);
      emit(VendorPlanListLoaded(response: response));
    } catch (e) {
      print("error: ${e.toString()}");
      emit(VendorPlanListError(error: e.toString()));
      print(e);
    }
  }


  vendorSubScribe(context,int subscribeId,String price,String type) async {
    var map = Map<String,String>();
    map['subscription_id'] = subscribeId.toString();
    map['price'] = price;
    map['type'] = type;
    emit(VendorSubscribeLoading());
    try {
      VendorSubscribeResponse response =
      await _repository.vendorSubscribe(context,map);
      emit(VendorSubscribeLoaded(response: response));
    } catch (e) {
      print("error: ${e.toString()}");
      emit(VendorSubscribeError(error: e.toString()));
      print(e);
    }
  }
}