import 'package:expense_tracker/features/dashboard/features/add/logics/add_state.dart';
import 'package:expense_tracker/features/dashboard/features/add/repository/add_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_event.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  AddBloc() : super(AddInitial()) {
    on<AddIncomeSubmitted>((event, emit) async {
      emit(AddLoading());

      try {
        final result = await AddRepository()
            .addIncome(event.uid, event.income, event.description);
        if (result.containsKey('status') && result['status'] == 'success') {
          emit(AddSuccess(message: result['message']));
        } else {
          emit(
              AddFailure(message: result['message'] ?? 'Something went wrong'));
        }
      } catch (e) {
        emit(AddFailure(message: e.toString()));
      }
    });
  }
}
