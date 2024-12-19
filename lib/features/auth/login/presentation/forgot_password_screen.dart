import 'package:expense_tracker/common/widgets/custombutton.dart';
import 'package:expense_tracker/common/widgets/customtextfield.dart';
import 'package:expense_tracker/features/auth/login/logics/login_bloc.dart';
import 'package:expense_tracker/features/auth/login/logics/login_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';

import '../logics/login_state.dart';

// ignore: must_be_immutable
class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // get theme
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: SafeArea(
          child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.loading,
              title: 'Please wait',
              barrierDismissible: false,
            );
          }

          if (state is ResetPasswordSuccess) {
            //close the loading dialog
            Navigator.pop(context);

            QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              title: 'Success',
              text: state.message,
              barrierDismissible: false,
              onConfirmBtnTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            );
          }

          if (state is ResetPasswordFailure) {
            //close the loading dialog

            Navigator.pop(context);

            QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Error',
                text: state.error);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'To reset your password, enter the email address you use to sign in to your account.',
              )
                  .animate()
                  .fade(
                    curve: Curves.easeIn,
                    duration: const Duration(milliseconds: 800),
                  )
                  .scaleXY(
                    begin: 0.9,
                    end: 1.0,
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: 800),
                  ),
              const SizedBox(height: 20),
              CustomTextField(
                  controller: emailController,
                  hintText: "Email Address",
                  isPassword: false,
                  keyboardType: TextInputType.emailAddress,
                  width: double.infinity,
                  height: 50,
                  isBordered: false,
                  backgroundColor: theme.onSurface.withOpacity(.1),
                  textColor: theme.onSurface,
                  hintColor: theme.onSurface.withOpacity(.5),
                  borderColor: theme.onSurface.withOpacity(.5),
                  leadingIcon: Icon(Icons.email, color: theme.primary)),
              const SizedBox(height: 20),
              CustomButton(
                  width: double.infinity,
                  height: 45,
                  text: "Reset Password",
                  onPressed: () {
                    final email = emailController.text;

                    if (email.isEmpty) {
                      QuickAlert.show(
                          context: context,
                          barrierDismissible: false,
                          text: "Please enter your email address!",
                          type: QuickAlertType.error);
                      return;
                    }

                    BlocProvider.of<LoginBloc>(context)
                        .add(ForgotPasswordSubmitted(email: email));
                  },
                  color: theme.primary,
                  textColor: theme.onPrimary,
                  isBordered: false)
                ..animate()
                    .fade(
                      curve: Curves.easeIn,
                      duration: const Duration(milliseconds: 800),
                    )
                    .scaleXY(
                      begin: 0.9,
                      end: 1.0,
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: 800),
                    )
            ],
          ),
        ),
      )),
    );
  }

  TextEditingController emailController = TextEditingController();
}
