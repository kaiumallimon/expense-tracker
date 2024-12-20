import 'package:equatable/equatable.dart';

abstract class TransactionsEvent extends Equatable {
  const TransactionsEvent();

  @override
  List<Object> get props => [];
}

class FetchTransactions extends TransactionsEvent {
  final String filter;
  final int limit;

  FetchTransactions({required this.filter, required this.limit});

  @override
  List<Object> get props => [filter, limit];
}
