abstract class TransactionsState {}

class TransactionsInitial extends TransactionsState {}

class TransactionsLoading extends TransactionsState {}

class TransactionsSuccess extends TransactionsState {
  final List<Map<String, dynamic>> transactions;

  TransactionsSuccess({required this.transactions});
}

class TransactionsFailure extends TransactionsState {
  final String message;

  TransactionsFailure({required this.message});
}
