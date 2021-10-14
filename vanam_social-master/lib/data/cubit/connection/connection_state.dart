import 'package:equatable/equatable.dart';
import 'package:vanam_social/data/remote/model/connection/connection_accept_list_response.dart';
import 'package:vanam_social/data/remote/model/connection/connection_accept_response.dart';
import 'package:vanam_social/data/remote/model/connection/connection_deny_response.dart';
import 'package:vanam_social/data/remote/model/connection/connection_response.dart';
import 'package:vanam_social/data/remote/model/connection/connetion_request_response.dart';
import 'package:vanam_social/data/remote/model/otp/otp_response.dart';

abstract class ConnectionsState extends Equatable {
  const ConnectionsState();

  @override
  List<Object> get props => [];
}

class ConnectionInitial extends ConnectionsState {}

class ConnectionLoading extends ConnectionsState {}
class ConnectionLoaded extends ConnectionsState {
  final ConnectionResponse response;
  ConnectionLoaded({required this.response});
}
class ConnectionError extends ConnectionsState {
  final String error;
  ConnectionError(this.error);
}

//connection request send
class ConnectionRequestLoading extends ConnectionsState {}
class ConnectionRequestLoaded extends ConnectionsState {
  final ConnectionRequestResponse response;
  ConnectionRequestLoaded({required this.response});
}
class ConnectionRequestError extends ConnectionsState {
  final String error;
  ConnectionRequestError(this.error);
}

//connection accept list
class ConnectionAcceptListLoading extends ConnectionsState {}
class ConnectionAcceptListLoaded extends ConnectionsState {
  final ConnectionAcceptListResponse response;
  ConnectionAcceptListLoaded({required this.response});
}
class ConnectionAcceptListError extends ConnectionsState {
  final String error;
  ConnectionAcceptListError(this.error);
}

// connection accept
class ConnectionAcceptLoading extends ConnectionsState {}
class ConnectionAcceptLoaded extends ConnectionsState {
  final ConnectionAcceptResponse response;
  ConnectionAcceptLoaded({required this.response});
}
class ConnectionAcceptError extends ConnectionsState {
  final String error;
  ConnectionAcceptError(this.error);
}

// connection deny
class ConnectionDenyLoading extends ConnectionsState {}
class ConnectionDenyLoaded extends ConnectionsState {
  final ConnectionDenyResponse response;
  ConnectionDenyLoaded({required this.response});
}
class ConnectionDenyError extends ConnectionsState {
  final String error;
  ConnectionDenyError(this.error);
}