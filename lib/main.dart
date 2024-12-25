import 'package:expense_tracker/features/dashboard/features/calender_view/logics/calender_view_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/common/theme/theming.dart';
import 'package:expense_tracker/features/auth/login/logics/login_bloc.dart';
import 'package:expense_tracker/features/auth/register/logics/register_bloc.dart';
import 'package:expense_tracker/features/dashboard/features/add/logics/add_bloc.dart';
import 'package:expense_tracker/features/dashboard/features/transactions/logics/transactions_bloc.dart';
import 'package:expense_tracker/features/startup/splash/presentation/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/dashboard/features/profile/logics/profile_cubit.dart';
import 'features/dashboard/features/profile/logics/theme_cubit.dart';
import 'features/dashboard/navigation/logics/navigation_cubit.dart';

void main() async {
  // ensure the binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // initialize firebase
  await Firebase.initializeApp();

  // Initialize the ThemeCubit and load the theme
  final themeCubit = ThemeCubit();
  await themeCubit.loadTheme();

  // run the app
  runApp(ExSyncApp(themeCubit: themeCubit));
}

class ExSyncApp extends StatelessWidget {
  const ExSyncApp({super.key, required this.themeCubit});

  final ThemeCubit themeCubit;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterBloc>(create: (context) => RegisterBloc()),
        BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
        BlocProvider<NavigationCubit>(create: (context) => NavigationCubit()),
        BlocProvider<AddBloc>(create: (context) => AddBloc()),
        BlocProvider<TransactionsBloc>(create: (context) => TransactionsBloc()),
        BlocProvider<ProfileCubit>(create: (context) => ProfileCubit()),
        // Provide the ThemeCubit
        BlocProvider<ThemeCubit>(create: (context) => themeCubit),
        BlocProvider<CalenderViewBloc>(create: (context) => CalenderViewBloc())
      ],
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, darkMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'ExSync',
            theme: darkMode ? getDarkTheme() : getTheme(),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
