import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable{
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterSubmitted extends RegisterEvent {
  final String name;
  final String email;
  final String password;
  final String phone;
  final String location;

  const RegisterSubmitted({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.location,
  });

  @override
  List<Object> get props => [name, email, password, phone, location];
}