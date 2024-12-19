import 'package:expense_tracker/features/auth/login/presentation/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';

import '../../../auth/login/logics/login_bloc.dart';
import '../../../auth/login/logics/login_event.dart';
import '../../../auth/login/logics/login_state.dart';

class DashboardWrapper extends StatelessWidget {
  const DashboardWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            QuickAlert.show(
                context: context,
                type: QuickAlertType.loading,
                title: 'Please wait',
                barrierDismissible: false,
                text: 'Logging out...');
          }

          if (state is LogoutSuccess) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          }

          if (state is LoginFailure) {
            QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Error',
                text: state.error);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text('Dashboard'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  BlocProvider.of<LoginBloc>(context).add(LogoutSubmitted());
                },
                child: const Text('Logout'))
          ],
        ),
      )),
    );
  }
}
