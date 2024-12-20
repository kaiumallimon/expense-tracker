import 'package:expense_tracker/features/dashboard/features/home/logics/home_state.dart';
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
        emit(HomeSuccess(totalBalance: totalBalance));
      } catch (e) {
        emit(HomeFailure(message: e.toString()));
      }
    });

    on<HomeReloadRequested>((event, emit) async {
      emit(HomeLoading());
      try {
        final totalBalance = await homeRepository.getTotalBalance(event.uid);
        emit(HomeSuccess(totalBalance: totalBalance));
      } catch (e) {
        emit(HomeFailure(message: e.toString()));
      }
    });
  }
}
