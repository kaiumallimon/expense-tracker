import 'package:expense_tracker/common/widgets/custombutton.dart';
import 'package:expense_tracker/features/auth/login/logics/login_bloc.dart';
import 'package:expense_tracker/features/auth/login/logics/login_event.dart';
import 'package:expense_tracker/features/auth/login/repository/login_repository.dart';
import 'package:expense_tracker/features/dashboard/features/home/repository/user_data_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../auth/login/logics/login_state.dart';
import '../../../../auth/login/presentation/login_screen.dart';
import '../logics/theme_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // get theme
    final theme = Theme.of(context).colorScheme;

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        }
      },
      child: FutureBuilder<Map<String, dynamic>>(
          future: UserDataRepository().getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            final userData = snapshot.data!;

            final String uid = userData['uid'];
            final String name = userData['name'];
            final String email = userData['email'];
            final String phone = userData['phone'];
            final String location = userData['location'];

            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Profile',
                        style: TextStyle(
                          color: theme.primary,
                          fontSize: 20,
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
                      // IconButton(
                      //   onPressed: () {
                      //     // Toggle the theme using the ThemeCubit
                      //     context.read<ThemeCubit>().toggleTheme();
                      //   },
                      //   icon: BlocBuilder<ThemeCubit, bool>(
                      //     builder: (context, darkMode) {
                      //       return Icon(
                      //         darkMode ? Icons.light_mode : Icons.dark_mode,
                      //         color: theme.onSurface,
                      //       );
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // User profile

                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/icons/user-2.png',
                      width: 100,
                      height: 100,
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

                  const SizedBox(height: 15),

                  Text(
                    name,
                    style: TextStyle(
                        color: theme.onSurface,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        height: 1),
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

                  Text(
                    "($email)",
                    style: TextStyle(
                        color: theme.onSurface,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1),
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Other Informations',
                        style: TextStyle(
                          color: theme.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
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

                  const SizedBox(height: 20),

                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: theme.primary.withOpacity(.2),
                    leading: Icon(Icons.phone, color: theme.primary),
                    title: Text(
                      'Phone',
                      style: TextStyle(
                        color: theme.primary,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      phone,
                      style: TextStyle(
                          color: theme.onSurface,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1),
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

                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: theme.primary.withOpacity(.2),
                    leading: Icon(Icons.location_on, color: theme.primary),
                    title: Text(
                      'Location',
                      style: TextStyle(
                        color: theme.primary,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      location,
                      style: TextStyle(
                          color: theme.onSurface,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1),
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Settings & Preferences',
                        style: TextStyle(
                          color: theme.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
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

                  const SizedBox(height: 20),

                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: theme.primary.withOpacity(.2),
                    leading: Icon(Icons.dark_mode, color: theme.primary),
                    title: Text(
                      'Dark Mode',
                      style: TextStyle(
                        color: theme.primary,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // Toggle the theme using the ThemeCubit
                    trailing: CupertinoSwitch(
                      value: context.watch<ThemeCubit>().state,
                      activeColor: theme.primary,
                      onChanged: (value) {
                        context.read<ThemeCubit>().toggleTheme();
                      },
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Others',
                        style: TextStyle(
                          color: theme.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
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

                  const SizedBox(height: 20),

                  CustomButton(
                          width: double.infinity,
                          height: 50,
                          text: "Log out",
                          onPressed: () {
                            BlocProvider.of<LoginBloc>(context)
                                .add(LogoutSubmitted());
                          },
                          color: theme.error,
                          textColor: theme.onError,
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
                      )
                ],
              ),
            );
          }),
    );
  }
}
