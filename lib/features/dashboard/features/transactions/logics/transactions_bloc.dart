import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For SharedPreferences
import '../repository/transactions_repository.dart';
import 'transactions_event.dart';
import 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsBloc() : super(TransactionsInitial()) {
    on<FetchTransactions>((event, emit) async {
      emit(TransactionsLoading());
      try {
        final prefs = await SharedPreferences.getInstance();
        final String uid = prefs.getString('uid')!;

        // Fetch filtered transactions based on the selected filter
        final transactions =
            await TransactionsRepository().getTransactions(uid);

        emit(TransactionsSuccess(transactions: transactions));
      } catch (e) {
        emit(TransactionsFailure(message: e.toString()));
      }
    });
  }
}
