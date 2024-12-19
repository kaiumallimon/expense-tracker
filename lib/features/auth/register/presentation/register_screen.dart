import 'package:expense_tracker/common/widgets/custombutton.dart';
import 'package:expense_tracker/features/auth/register/logics/register_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';

import '../../login/presentation/login_screen.dart';
import '../logics/register_bloc.dart';
import '../logics/register_event.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  InputDecoration _customInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
          fontSize: 16,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(.5)),
      prefixIcon: Icon(
        icon,
        color: Theme.of(context).colorScheme.onSurface.withOpacity(.5),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(width: 2, color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(width: 2, color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:
            BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: theme.surface,
      statusBarIconBrightness: theme.brightness,
      systemNavigationBarColor: theme.surface,
      systemNavigationBarIconBrightness: theme.brightness,
    ));
    return Scaffold(
      body: SafeArea(
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            // Handle RegisterLoading state
            if (state is RegisterLoading) {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.loading,
                title: 'Loading',
                text: 'Please wait...',
                barrierDismissible: false,
              );
            }

            // Handle RegisterSuccess state
            if (state is RegisterSuccess) {
              // Hide the loading dialog
              Navigator.of(context).pop();

              QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                title: 'Success',
                text: state.message,
                barrierDismissible: false,
              );

              // Clear the form controllers
              _nameController.clear();
              _emailController.clear();
              _passwordController.clear();
              _phoneController.clear();
              _locationController.clear();

              // Navigate to the LoginScreen
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            }

            // Handle RegisterFailure state
            if (state is RegisterFailure) {
              // Hide the loading dialog
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }

              QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Error',
                text: state.message,
                barrierDismissible: false,
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton.filled(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 20,
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
                    const SizedBox(height: 20),
                    const Text(
                      'Setup your account',
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold, height: 1),
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
                    Text('To get started, continue creating your account',
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey.shade600))
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
                    TextFormField(
                      controller: _nameController,
                      decoration:
                          _customInputDecoration('Full Name', Icons.person),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
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
                    TextFormField(
                      controller: _emailController,
                      decoration:
                          _customInputDecoration('Email Address', Icons.email),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        // if (!RegExp(r'^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}\$')
                        //     .hasMatch(value)) {
                        //   return 'Please enter a valid email address';
                        // }
                        return null;
                      },
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
                    TextFormField(
                      controller: _phoneController,
                      decoration:
                          _customInputDecoration('Phone number', Icons.phone),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }

                        return null;
                      },
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
                    TextFormField(
                      controller: _locationController,
                      decoration: _customInputDecoration(
                          'Location', CupertinoIcons.location_fill),
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Location';
                        }

                        return null;
                      },
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
                    TextFormField(
                      controller: _passwordController,
                      decoration:
                          _customInputDecoration('Password', Icons.lock),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
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
                    CustomButton(
                        width: double.infinity,
                        height: 50,
                        text: "Sign up",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            String name = _nameController.text.trim();
                            String email = _emailController.text.trim();
                            String password = _passwordController.text.trim();
                            String phone = _phoneController.text.trim();
                            String location = _locationController.text.trim();

                            BlocProvider.of<RegisterBloc>(context).add(
                              RegisterSubmitted(
                                  name: name,
                                  email: email,
                                  password: password,
                                  phone: phone,
                                  location: location),
                            );
                          }
                        },
                        color: theme.primary,
                        textColor: theme.onPrimary,
                        isBordered: false),
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
