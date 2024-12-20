import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final double totalBalance;
  final List<Map<String, dynamic>> expenses;
  final List<Map<String, dynamic>> incomes;
  final List<Map<String, dynamic>> latestTransactions;

  const HomeSuccess(
      {required this.totalBalance,
      required this.expenses,
      required this.incomes,
      required this.latestTransactions});

  @override
  List<Object> get props => [totalBalance];
}

class HomeFailure extends HomeState {
  final String message;

  const HomeFailure({required this.message});

  @override
  List<Object> get props => [message];
}
