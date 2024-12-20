import 'package:expense_tracker/common/theme/theming.dart';
import 'package:expense_tracker/features/auth/login/logics/login_bloc.dart';
import 'package:expense_tracker/features/auth/register/logics/register_bloc.dart';
import 'package:expense_tracker/features/dashboard/features/add/logics/add_bloc.dart';
import 'package:expense_tracker/features/dashboard/features/transactions/logics/transactions_bloc.dart';
import 'package:expense_tracker/features/startup/splash/presentation/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/dashboard/navigation/logics/navigation_cubit.dart';

void main() async {
  // ensure the binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // initialize firebase
  await Firebase.initializeApp();

  // run the app
  runApp(const ExSyncApp());
}

class ExSyncApp extends StatelessWidget {
  const ExSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Register bloc
        BlocProvider<RegisterBloc>(create: (context) => RegisterBloc()),
        // Login bloc
        BlocProvider<LoginBloc>(create: (context) => LoginBloc()),

        // add navigation cubit here
        BlocProvider<NavigationCubit>(create: (context) => NavigationCubit()),

        // add provider
        BlocProvider<AddBloc>(create: (context) => AddBloc()),

        //transactions bloc

        BlocProvider<TransactionsBloc>(
            create: (context) => TransactionsBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ExSync',
        theme: getTheme(),
        home: const SplashScreen(),
      ),
    );
  }
}
