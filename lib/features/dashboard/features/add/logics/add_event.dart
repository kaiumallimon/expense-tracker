import 'package:equatable/equatable.dart';

abstract class AddEvent extends Equatable {
  const AddEvent();

  @override
  List<Object> get props => [];
}


class AddIncomeSubmitted extends AddEvent {
  final String uid;
  final double income;
  final String description;

  const AddIncomeSubmitted({
    required this.uid,
    required this.income,
    required this.description
  });

  @override
  List<Object> get props => [uid, income, description];
}


class AddExpenseSubmitted extends AddEvent {
  final String uid;
  final double expense;
  final String description;

  const AddExpenseSubmitted({
    required this.uid,
    required this.expense,
    required this.description
  });

  @override
  List<Object> get props => [uid, expense, description];
}
