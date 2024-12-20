import 'package:expense_tracker/features/auth/login/presentation/login_screen.dart';
import 'package:expense_tracker/features/dashboard/features/add/presentation/add_screen.dart';
import 'package:expense_tracker/features/dashboard/features/calender_view/presentation/calender_view.dart';
import 'package:expense_tracker/features/dashboard/features/home/presentations/home_screen.dart';
import 'package:expense_tracker/features/dashboard/features/profile/presentation/profile_screen.dart';
import 'package:expense_tracker/features/dashboard/features/transactions/presentation/transactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';

import '../../../auth/login/logics/login_bloc.dart';
import '../../../auth/login/logics/login_state.dart';
import '../../navigation/logics/navigation_cubit.dart';
import '../../navigation/presentation/bottomnav.dart';

class DashboardWrapper extends StatelessWidget {
  const DashboardWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // retain status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    // get the theme
    final theme = Theme.of(context).colorScheme;

    // change  status bar color
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: theme.surface,
      statusBarIconBrightness: theme.brightness,
      systemNavigationBarColor: Color.alphaBlend(
        theme.primary.withOpacity(0.08), // Tint effect
        theme.surface,
      ),
      systemNavigationBarIconBrightness: theme.brightness,
    ));

    return SafeArea(
      child: Scaffold(
        body: BlocListener<LoginBloc, LoginState>(listener: (context, state) {
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
        }, child: BlocBuilder<NavigationCubit, int>(builder: (context, state) {
          List<Widget> screens = [
            const HomeScreen(),
            TransactionsScreen(),
            const AddScreen(),
            const CalenderView(),
            const ProfileScreen(),
          ];

          return screens[BlocProvider.of<NavigationCubit>(context).state];
        })),
        bottomNavigationBar: BlocBuilder<NavigationCubit, int>(
            bloc: BlocProvider.of<NavigationCubit>(context),
            builder: (context, state) {
              return CustomBottomNavbar(selectedIndex: state);
            }),
      ),
    );
  }
}
