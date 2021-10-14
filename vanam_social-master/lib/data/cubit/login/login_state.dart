
import 'package:equatable/equatable.dart';
import 'package:vanam_social/data/remote/model/login/login_response.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  final LoginResponse login;

  LoginLoaded({required this.login});

}

class LoginError extends LoginState {
  final String error;

  LoginError(this.error);
}