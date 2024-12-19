import 'package:expense_tracker/features/auth/login/logics/login_state.dart';
import 'package:expense_tracker/features/auth/login/repository/login_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('welcomeSeen', true);

      // initially set the state to LoginLoading
      emit(LoginLoading());

      // Add login logic here
      Map<String, dynamic> response =
          await LoginRepository().login(event.email, event.password);

      if (response.containsKey('error')) {
        emit(LoginFailure(error: response['error'] as String));
      } else {
        // Save user data to shared preferences
        String name = response['userData']['name'] as String;
        String email = response['userData']['email'] as String;
        String uid = response['user'].uid;
        String phoneNumber = response['userData']['phone'] as String;
        String location = response['userData']['location'] as String;

        prefs.setString('name', name);
        prefs.setString('email', email);
        prefs.setString('uid', uid);
        prefs.setString('phone', phoneNumber);
        prefs.setString('location', location);

        // change the state to LoginSuccess

        emit(const LoginSuccess(message: "Login successful!"));
      }
    });

    on<ForgotPasswordSubmitted>((event, emit) async {
      emit(LoginLoading());

      bool response = await LoginRepository().resetPassword(event.email);

      if (response) {
        emit(const ResetPasswordSuccess(
            message:
                "Password reset email sent! Please follow the instructions in the email."));
      } else {
        emit(const ResetPasswordFailure(
            error: "Failed to send password reset email!"));
      }
    });

    on<LogoutSubmitted>((event, emit) async {
      emit(LoginLoading());

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('name');
      prefs.remove('email');
      prefs.remove('uid');
      prefs.remove('phone');
      prefs.remove('location');

      emit(const LogoutSuccess());
    });
  }
}
