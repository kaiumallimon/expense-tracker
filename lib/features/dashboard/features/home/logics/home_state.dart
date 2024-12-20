import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable{
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final double totalBalance;

  const HomeSuccess({required this.totalBalance});

  @override
  List<Object> get props => [totalBalance];
}

class HomeFailure extends HomeState {
  final String message;

  const HomeFailure({required this.message});

  @override
  List<Object> get props => [message];
}