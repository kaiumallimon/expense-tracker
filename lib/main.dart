import 'package:expense_tracker/common/theme/theming.dart';
import 'package:expense_tracker/features/startup/splash/presentation/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  // ensure the binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // initialize firebase
  await Firebase.initializeApp();

  // run the app
  runApp(ExSyncApp());
}

class ExSyncApp extends StatelessWidget {
  const ExSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ExSync',
      theme: getTheme(),
      home: SplashScreen(),
    );
  }
}
