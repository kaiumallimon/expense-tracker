import 'package:expense_tracker/common/widgets/custombutton.dart';
import 'package:expense_tracker/features/auth/login/presentation/login_screen.dart';
import 'package:expense_tracker/features/auth/register/presentation/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      body: Stack(
        children: [
          // background image
          Positioned.fill(
              child: Image.asset(
            'assets/images/welcome_screen.png',
            fit: BoxFit.cover,
          )),

          // app name
          Positioned(
            top: 60,
            left: 40,
            child: Text(
              'ExSync',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: theme.onPrimary,
              ),
            )
                .animate()
                .fade(
                  curve: Curves.easeIn,
                  duration: const Duration(milliseconds: 800),
                )
                .scaleXY(
                  begin: 0.8,
                  end: 1.0,
                  curve: Curves.easeOut,
                  duration: const Duration(milliseconds: 800),
                ),
          ),

          // bottom title
          Positioned(
            bottom: 100 + MediaQuery.of(context).padding.bottom,
            left: 40,
            right: 40,
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.track_changes,
                      color: theme.tertiary,
                      size: 30,
                    )
                        .animate()
                        .fade(
                          curve: Curves.easeIn,
                          duration: const Duration(milliseconds: 800),
                        )
                        .scaleXY(
                          begin: 0.8,
                          end: 1.0,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 800),
                        ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Track, manage, and analyze your expenses with our powerful insights.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16,
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
                    ),
                  ],
                ),
              ],
            ),
          ),

          // custom button
          Positioned(
            bottom: 30 + MediaQuery.of(context).padding.bottom,
            left: 40,
            right: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  text: 'Get Started',
                  width: MediaQuery.of(context).size.width - 80,
                  height: 50,
                  isBordered: false,
                  color: theme.tertiary,
                  shadowColor: theme.tertiary,
                  textColor: Colors.black,
                  elevation: 10,
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setBool('welcomeSeen', true);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
