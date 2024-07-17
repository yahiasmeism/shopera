import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/persentation/pages/home_page.dart';
import 'package:shopera/core/widgets/button_primary.dart';
import 'package:shopera/features/authentication/presentation/pages/register_page.dart';
import 'package:shopera/features/authentication/presentation/pages/update_user_page.dart';
import 'package:shopera/features/authentication/presentation/cubits/user_cubit/cubit.dart';
import 'package:shopera/features/authentication/presentation/widgets/text_form_field.dart';
import 'package:shopera/features/authentication/presentation/widgets/primary_button_google.dart';
import 'package:shopera/features/authentication/presentation/widgets/custom_password_form_field.dart';




// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  static const routeName = 'login';
  bool isPassword = true;

  LoginPage({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         automaticallyImplyLeading: true,
      ),
        body: BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserSuccess) {
          // Navigate to home or another page
          Navigator.of(context).pushNamedAndRemoveUntil(HomePage.routeName,(route) => false,);
        } else if (state is UserFailure) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // App logo and name
                  Image.asset(
                    'assets/images/logo.png',
                    height: 45,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Welcome Back!',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // UserName input
                  TextFormFieldWidget(
                    controller: _usernameController,
                    type: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                    label: 'Enter your username',
                    prefix: Icons.person,
                  ),
                  const SizedBox(height: 10),

                  // password input
                  CustomPasswordFormField(controller: _passwordController),
                 
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(UpdateUserPage.routeName);
                      },
                      child: const Text('Forgot Password?'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Login button
                  BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      if (state is UserLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return PrimaryButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            context.read<UserCubit>().loginUser(
                                  username: _usernameController.text,
                                  password: _passwordController.text,
                                );
                          }
                        },
                        labelText: 'Login',
                        height: 55,
                      );
                    },
                  ),

                  const SizedBox(height: 20),
                  // Divider
                  const Row(
                    children: [
                      Expanded(child: Divider(thickness: 1)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('or continue with'),
                      ),
                      Expanded(child: Divider(thickness: 1)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Google sign-in button
                  PrimaryButtonGoogle(context: context),

                  const SizedBox(height: 20),
                  // Sign-up link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(RegisterPage.routeName);
                        },
                        child: const Text('Sign up'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
