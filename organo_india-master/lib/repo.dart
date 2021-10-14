import 'package:flutter/material.dart';
import 'package:organo_india/model/otp/otp_model.dart';
import 'data/api/ApiProvider.dart';
import 'package:organo_india/model/register/register_model.dart';
import 'package:organo_india/model/address/country_model.dart';

class Repo {
  ApiProvider _apiprovider = ApiProvider();
  Future<OtpModel> sendOTP(
      BuildContext context, Map<String, String> map) async {
    final response = await _apiprovider.post(context, "otp", map);
    return OtpModel.fromJson(response);
  }

  Future<RegisterModel> registerUser(
      BuildContext context, Map<String, String> map) async {
    final response = await _apiprovider.post(context, "register", map);
    return RegisterModel.fromJson(response);``
  }

  Future<CountryModel> getCountry(
      BuildContext context, Map<String, String> map) async {
    final response = await _apiprovider.get(context, "register", map);
    return CountryModel.fromJson(response);
  }
}
