import 'package:expense_tracker/features/auth/register/logics/register_state.dart';
import 'package:expense_tracker/features/auth/register/repository/register_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_event.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterSubmitted>((event, emit) async {
      emit(RegisterLoading());
      final result = await RegisterRepository().registerUser(
        name: event.name,
        email: event.email,
        password: event.password,
        phone: event.phone,
        location: event.location,
      );
      if (result['status']) {
        emit(RegisterSuccess(message: result['message']));
      } else {
        emit(RegisterFailure(message: result['message']));
      }
    });
  }
}
