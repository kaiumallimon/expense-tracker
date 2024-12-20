import 'package:equatable/equatable.dart';

abstract class AddState extends Equatable{
  const AddState();

  @override
  List<Object> get props => [];
}


class AddInitial extends AddState {}

class AddLoading extends AddState {}

class AddSuccess extends AddState {
  final String message;

  const AddSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class AddFailure extends AddState {
  final String message;

  const AddFailure({required this.message});

  @override
  List<Object> get props => [message];
}

