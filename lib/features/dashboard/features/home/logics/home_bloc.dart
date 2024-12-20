import 'package:expense_tracker/features/dashboard/features/home/logics/home_state.dart';
import 'package:expense_tracker/features/dashboard/features/home/repository/report_repository.dart';
import 'package:expense_tracker/features/dashboard/features/transactions/repository/transactions_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/home_repository.dart';
import 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;

  HomeBloc({required this.homeRepository}) : super(HomeInitial()) {
    on<HomeInitialEvent>((event, emit) async {
      emit(HomeLoading());
      try {
        final totalBalance = await homeRepository.getTotalBalance(event.uid);

        final totalExpenses =
            await ReportRepository().getExpensesLast6Months(event.uid);
        final totalIncomes =
            await ReportRepository().getIncomesLast6Months(event.uid);

        final latestTransactions =
            await TransactionsRepository().getLatestTransactions(event.uid);

        emit(HomeSuccess(
            totalBalance: totalBalance,
            expenses: totalExpenses,
            incomes: totalIncomes,
            latestTransactions: latestTransactions));
      } catch (e) {
        emit(HomeFailure(message: e.toString()));
      }
    });

    on<HomeReloadRequested>((event, emit) async {
      emit(HomeLoading());
      try {
        final totalBalance = await homeRepository.getTotalBalance(event.uid);
        final totalExpenses =
            await ReportRepository().getExpensesLast6Months(event.uid);
        final totalIncomes =
            await ReportRepository().getIncomesLast6Months(event.uid);

        final latestTransactions =
            await TransactionsRepository().getLatestTransactions(event.uid);
        emit(HomeSuccess(
            totalBalance: totalBalance,
            expenses: totalExpenses,
            incomes: totalIncomes,
            latestTransactions: latestTransactions));
      } catch (e) {
        emit(HomeFailure(message: e.toString()));
      }
    });
  }
}
