import 'package:equatable/equatable.dart';
import 'package:vanam_social/data/remote/model/otp/otp_response.dart';

abstract class OtpState extends Equatable {
  const OtpState();

  @override
  List<Object> get props => [];
}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpLoaded extends OtpState {
  final OtpResponse response;

  OtpLoaded({required this.response});

}

class OtpError extends OtpState {
  final String error;

  OtpError(this.error);
}