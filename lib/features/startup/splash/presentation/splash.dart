import 'package:expense_tracker/features/auth/login/presentation/login_screen.dart';
import 'package:expense_tracker/features/dashboard/wrapper/presentation/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../welcome/presentation/welcome.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get theme:
    final theme = Theme.of(context).colorScheme;

    // Hide the status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // After 2 seconds, navigate to the appropriate screen
    Future.delayed(const Duration(seconds: 2), () async {
      // Check if the user has already seen the welcome screen
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool seen = prefs.getBool('welcomeSeen') ?? false;
      String? uid = prefs.getString('uid');

      print('Seen: $seen');
      print('UID: $uid');

      if (uid != null) {
        // Navigate to the DashboardScreen if the UID is present
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardWrapper()),
        );
      } else if (seen) {
        // Navigate to the LoginScreen if the user has seen the welcome screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        // Navigate to the WelcomeScreen otherwise
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
        );
      }
    });

    return Scaffold(
      backgroundColor: theme.secondary,
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
        ),
      ),
    );
  }
}
