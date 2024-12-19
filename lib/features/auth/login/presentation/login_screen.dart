import 'package:expense_tracker/common/widgets/custombutton.dart';
import 'package:expense_tracker/common/widgets/customsocialbutton.dart';
import 'package:expense_tracker/common/widgets/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';

import '../../../dashboard/wrapper/presentation/dashboard.dart';
import '../../register/presentation/register_screen.dart';
import '../logics/login_bloc.dart';
import '../logics/login_event.dart';
import '../logics/login_state.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get theme:
    final theme = Theme.of(context).colorScheme;

    // Hide the status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    // Set the status bar and navigation bar colors
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: theme.surface,
      statusBarIconBrightness: theme.brightness,
      systemNavigationBarColor: theme.surface,
      systemNavigationBarIconBrightness: theme.brightness,
    ));

    return Scaffold(
      body: SafeArea(
          child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            QuickAlert.show(
                context: context,
                title: 'Logging in',
                text: 'Please wait...',
                barrierDismissible: false,
                type: QuickAlertType.loading);
          } else if (state is LoginSuccess) {
            Navigator.of(context).pop();

            // navigate to dashboard

            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return DashboardWrapper();
            }));
          } else if (state is LoginFailure) {
            // hide the loading dialog

            Navigator.of(context).pop();
            // show the error message
            QuickAlert.show(
                context: context,
                title: 'Login Failed',
                text: state.error,
                barrierDismissible: false,
                type: QuickAlertType.error);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: theme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.lock,
                  size: 30,
                  color: theme.onPrimary,
                ),
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
              const SizedBox(height: 30),
              const Text(
                'Login to your account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
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
              const SizedBox(height: 10),
              Text('Please login with your registered email and password to continue.',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: theme.onSurface.withOpacity(.5),
                      ))
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

              const SizedBox(height: 30),

              // Email field
              const Text(
                'Email',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
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
              const SizedBox(height: 10),
              CustomTextField(
                controller: _emailController,
                hintText: "Enter your email address",
                isPassword: false,
                keyboardType: TextInputType.emailAddress,
                width: double.infinity,
                height: 50,
                isBordered: false,
                backgroundColor: theme.onSurface.withOpacity(.1),
                textColor: theme.onSurface,
                borderColor: theme.onSurface.withOpacity(.5),
                hintColor: theme.onSurface.withOpacity(.5),
                leadingIcon: Icon(
                  Icons.email,
                  color: theme.primary,
                ),
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

              const SizedBox(height: 10),

              const Text(
                'Password',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
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
              const SizedBox(height: 10),
              // Password field
              CustomTextField(
                controller: _passwordController,
                hintText: "Enter your password",
                isPassword: true,
                keyboardType: TextInputType.visiblePassword,
                width: double.infinity,
                height: 50,
                isBordered: false,
                backgroundColor: theme.onSurface.withOpacity(.1),
                textColor: theme.onSurface,
                borderColor: theme.onSurface.withOpacity(.5),
                hintColor: theme.onSurface.withOpacity(.5),
                leadingIcon: Icon(
                  Icons.lock,
                  color: theme.primary,
                ),
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

              const SizedBox(height: 10),

              // Forgot password

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ForgotPasswordScreen();
                      }));
                    },
                    child: Text(
                      'Forgot password?',
                      style: GoogleFonts.poppins(
                        color: theme.error,
                        fontWeight: FontWeight.w500,
                        // decoration: TextDecoration.underline,
                        // decorationColor: theme.error,
                      ),
                    ),
                  ),
                ],
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

              const SizedBox(height: 10),

              // Login button

              CustomButton(
                      width: double.infinity,
                      height: 50,
                      text: "Login",
                      onPressed: () {
                        // dispatch the login event
                        BlocProvider.of<LoginBloc>(context).add(LoginSubmitted(
                            email: _emailController.text,
                            password: _passwordController.text));
                      },
                      color: theme.primary,
                      textColor: theme.onPrimary,
                      isBordered: false)
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

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: GoogleFonts.poppins(
                        color: theme.onSurface, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                    },
                    child: Text(
                      'Create an account',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: GoogleFonts.poppins(
                        color: theme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
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

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Or',
                      style: TextStyle(color: theme.onSurface.withOpacity(.5))),
                ],
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

              // Google sign in button

              CustomSocialButton(
                width: double.infinity,
                height: 50,
                text: 'Continue with Google',
                onPressed: () {
                  QuickAlert.show(
                      context: context,
                      title: 'Google Sign In',
                      text: 'Not implemented yet.',
                      barrierDismissible: false,
                      cancelBtnText: "OK",
                      type: QuickAlertType.warning);
                },
                color: theme.onSurface.withOpacity(.1),
                textColor: theme.onSurface,
                isBordered: false,
                imagePath: 'assets/icons/google.png',
                imageSize: 25,
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
            ],
          ),
        ),
      )),
    );
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
}
