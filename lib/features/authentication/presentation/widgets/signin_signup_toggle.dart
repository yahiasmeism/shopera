import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';

class LoginSignUpToggle extends StatefulWidget {
  const LoginSignUpToggle({super.key});

  @override
  _LoginSignUpToggleState createState() => _LoginSignUpToggleState();
}

class _LoginSignUpToggleState extends State<LoginSignUpToggle> {
  bool isLoginSelected = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 33;

    return Stack(
      children: [
        Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          left: isLoginSelected ? 0 : width / 2,
          child: Container(
            height: 60,
            width: width / 2,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        Positioned.fill(
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isLoginSelected = true;
                    });
                    Navigator.pushNamed(context, LoginPage.routeName);
                  },
                  child: Center(
                    child: Text(
                      'Sign-in',
                      style: TextStyle(
                        color: isLoginSelected ? Colors.white : AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isLoginSelected = false;
                    });
                    Navigator.pushNamed(context, RegisterPage.routeName);
                  },
                  child: Center(
                    child: Text(
                      'Sign-up',
                      style: TextStyle(
                        color: isLoginSelected ? AppColors.primaryColor : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
