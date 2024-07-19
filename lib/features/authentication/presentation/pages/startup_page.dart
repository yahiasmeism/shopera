import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../widgets/login_signup_toggle.dart';

class StartupPage extends StatefulWidget {
  static const routeName = 'startup';

  const StartupPage({super.key});

  @override
  State<StartupPage> createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  var boardController = PageController();

  @override
  Widget build(BuildContext context) {
    List<String> boarding = [
      'assets/images/startup_screen.png',
      'assets/images/startup_screen2.png',
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 90),
            // App logo and name
            Image.asset(
              'assets/images/logo.png',
              height: 45,
            ),
            Expanded(
              flex: 3,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      index = 0;
                    });
                  }
                },
                controller: boardController,
                itemCount: boarding.length,
                itemBuilder: (context, index) => Image.asset(
                  boarding[index],
                  height: 300,
                ),
              ),
            ),

            SmoothPageIndicator(
              controller: boardController,
              count: boarding.length,
              effect: const ExpandingDotsEffect(
                dotColor: Colors.grey,
                activeDotColor: AppColors.dotColor,
                dotHeight: 10,
                dotWidth: 10,
                // spacing between dots
                expansionFactor: 3.5,
                spacing: 5.0,
              ),
            ),

            const Spacer(flex: 1),
            const Text(
              'Lorem ipsum dolor.',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 13),
            Text(
              'Lorem ipsum dolor sit amet, consectetur\nadipiscing elit, sed do eiusmod tempor\nincididunt ut labore et dolore',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const Spacer(flex: 1),
            // button bar
            const LoginSignUpToggle(),
          ],
        ),
      ),
    );
  }
}
