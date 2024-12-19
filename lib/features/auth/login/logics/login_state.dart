import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String message;

  const LoginSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class LogoutSuccess extends LoginState {

  const LogoutSuccess();

  @override
  List<Object> get props => [];
} 


class ResetPasswordSuccess extends LoginState {
  final String message;

  const ResetPasswordSuccess({required this.message});

  @override
  List<Object> get props => [message];
} 


class ResetPasswordFailure extends LoginState {
  final String error;

  const ResetPasswordFailure({required this.error});

  @override
  List<Object> get props => [error];
}