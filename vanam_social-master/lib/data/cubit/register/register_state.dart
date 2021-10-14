
import 'package:equatable/equatable.dart';
import 'package:vanam_social/data/remote/model/register/register_response.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterLoaded extends RegisterState {
  final RegisterRespnse response;

  RegisterLoaded({required this.response});

}

class RegisterError extends RegisterState {
  final String error;

  RegisterError(this.error);
}