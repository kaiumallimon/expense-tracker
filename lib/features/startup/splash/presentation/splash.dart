import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../welcome/presentation/welcome.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // get theme:
    final theme = Theme.of(context).colorScheme;

    // hide the status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // after 2 seconds, navigate to the welcome screen
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
    });

    return Scaffold(
      backgroundColor: theme.tertiary,
      body: SafeArea(
          child: Center(
        child: SizedBox(
          width: 150,
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icons/icons8-turkish-lira-96.png'),
              const SizedBox(height: 10),
              Text(
                'ExSync',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: theme.onTertiary,
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
