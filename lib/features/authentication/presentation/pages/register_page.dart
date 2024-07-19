import 'login_page.dart';
import 'package:flutter/material.dart';
import '../cubits/user_cubit/cubit.dart';
import '../widgets/text_form_field.dart';
import '../widgets/primary_button_google.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/custom_password_form_field.dart';
import '../../../../core/widgets/button_primary.dart';
import '../../../../core/utils/my_route_observer.dart';
import '../../../home/persentation/pages/home_page.dart';

class SignUpPage extends StatelessWidget {
  static const routeName = 'register';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SignUpPage({super.key});

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
            Navigator.of(context).pushNamedAndRemoveUntil(
              HomePage.routeName,
              (route) => false,
            );
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
                      'Create an Account',
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
                    // email input
                    TextFormFieldWidget(
                      controller: _emailController,
                      label: 'Enter your email',
                      prefix: Icons.email,
                      type: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    // Password input
                    CustomPasswordFormField(controller: _passwordController),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('Forgot Password?'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Register button
                    BlocBuilder<UserCubit, UserState>(
                      builder: (context, state) {
                        if (state is UserLoading) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        return PrimaryButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              context.read<UserCubit>().registerUser(
                                    username: _usernameController.text,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    isFromGoogle: false,
                                  );
                            }
                          },
                          labelText: 'Register',
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
                            if (AppNavigatorObserver().isRoutePresent(SignInPage.routeName)) {
                              Navigator.popUntil(context, ModalRoute.withName(SignInPage.routeName));
                            } else {
                              Navigator.pushNamed(context, SignInPage.routeName);
                            }
                          },
                          child: const Text('Sign in'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
