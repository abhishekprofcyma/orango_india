import 'package:equatable/equatable.dart';
import 'package:vanam_social/data/remote/model/otp/otp_response.dart';
import 'package:vanam_social/data/remote/model/reset_password/reset_password_response.dart';

abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object> get props => [];
}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordLoading extends ResetPasswordState {}

class ResetPasswordLoaded extends ResetPasswordState {
  final ResetPasswordResponse response;

  ResetPasswordLoaded({required this.response});

}

class ResetPasswordError extends ResetPasswordState {
  final String error;

  ResetPasswordError(this.error);
}