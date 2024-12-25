import 'package:expense_tracker/features/dashboard/features/calender_view/logics/calender_view_state.dart';
import 'package:expense_tracker/features/dashboard/features/calender_view/repository/calender_view_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'calender_view_event.dart';

class CalenderViewBloc extends Bloc<CalenderViewEvent, CalenderViewState> {
  CalenderViewBloc() : super(CalenderViewInitial()) {
    on<LoadCalenderView>(_onLoadCalenderView);
  }

  Future<void> _onLoadCalenderView(
      LoadCalenderView event, Emitter<CalenderViewState> emit) async {
    try {
      // Emit loading state
      emit(CalenderViewLoading());

      // Get the UID
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final uid = prefs.getString('uid');

      if (uid == null) {
        emit(const CalenderViewError("User ID not found"));
        return;
      }

      // Fetch data
      final data = await CalenderViewRepository().getAllDataByDate(uid);

      // Emit loaded state
      emit(CalenderViewLoaded(data));
    } catch (e) {
      // Emit error state
      emit(CalenderViewError("Failed to load calendar data: ${e.toString()}"));
    }
  }
}
