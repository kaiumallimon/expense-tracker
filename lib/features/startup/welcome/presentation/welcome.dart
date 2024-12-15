import 'package:cached_network_image/cached_network_image.dart';
import 'package:expense_tracker/common/widgets/custombutton.dart';
import 'package:expense_tracker/features/auth/register/presentation/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final PageController controller = PageController();

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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text(
                          'Skip to Login',
                          style: TextStyle(
                            color: theme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Icon(Icons.arrow_forward, color: theme.primary),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: PageView.builder(
                itemCount: 3,
                controller: controller,
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return _buildPage(
                        title: 'Welcome to ExSync',
                        description:
                            'Take charge of your spendings effortlessly\nand track your expenses with ease.',
                        imagePath:
                            'https://media.istockphoto.com/id/1279952311/vector/electronic-documentation-vector-concept-metaphor.jpg?s=612x612&w=0&k=20&c=HHql3BU8fEqaFE2JBgjPB6Grp7EkmeoZ42vi8IIFEUI=',
                        theme: theme,
                      );
                    case 1:
                      return _buildPage(
                        title: 'Get Insights',
                        description:
                            'Track, manage, and analyze your expenses\nwith our powerful insights.',
                        imagePath:
                            'https://media.licdn.com/dms/image/D5612AQGplp7JKG6Iiw/article-cover_image-shrink_720_1280/0/1673950361361?e=2147483647&v=beta&t=NxzErCoXqQ-xwkHJZZkKGKYNA21hJh3oNMUJzNKQr9M',
                        theme: theme,
                      );
                    case 2:
                      return _buildLastPage(theme, context);
                    default:
                      return const SizedBox.shrink();
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            SmoothPageIndicator(
              controller: controller,
              count: 3,
              axisDirection: Axis.horizontal,
              effect: WormEffect(
                  dotHeight: 10, dotWidth: 10, activeDotColor: theme.primary),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPage({
    required String title,
    required String description,
    required String imagePath,
    required ColorScheme theme,
  }) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: theme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: theme.onSurface.withOpacity(0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: CachedNetworkImage(
                imageUrl: imagePath,
                height: 250,
                progressIndicatorBuilder: (context, url, progress) {
                  return Center(
                    child: CircularProgressIndicator(
                      value: progress.progress,
                      valueColor: AlwaysStoppedAnimation(theme.primary),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: theme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: theme.onSurface,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLastPage(ColorScheme theme, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: theme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: theme.onSurface.withOpacity(0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: CachedNetworkImage(
                imageUrl:
                    'https://img.freepik.com/free-vector/tiny-people-preparing-invoice-computer-isolated-flat-illustration_74855-11116.jpg',
                height: 250,
                progressIndicatorBuilder: (context, url, progress) {
                  return Center(
                    child: CircularProgressIndicator(
                      value: progress.progress,
                      valueColor: AlwaysStoppedAnimation(theme.primary),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Column(
              children: [
                Text(
                  "Your data is secured",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: theme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'We take your privacy seriously. Your data is\nsecured and encrypted.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: theme.onSurface,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                        width: 150,
                        height: 45,
                        text: "Register",
                        onPressed: () async {
                          // dont show the welcome screen again
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();

                          preferences.setBool('showWelcome', false);

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen()));
                        },
                        color: theme.primary,
                        textColor: theme.onPrimary,
                        isBordered: false),
                    CustomButton(
                        width: 150,
                        height: 45,
                        text: "Login",
                        onPressed: () {},
                        color: theme.primary,
                        textColor: theme.onPrimary,
                        isBordered: true),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
