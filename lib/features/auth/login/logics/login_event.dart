import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;

  const LoginSubmitted({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class ForgotPasswordSubmitted extends LoginEvent {
  final String email;

  const ForgotPasswordSubmitted({required this.email});

  @override
  List<Object> get props => [email];
}


class LogoutSubmitted extends LoginEvent {
  const LogoutSubmitted();

  @override
  List<Object> get props => [];
}