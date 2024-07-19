import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopera/core/constants/strings.dart';
import 'package:shopera/core/widgets/button_primary.dart';
import 'package:shopera/core/widgets/snackbar_global.dart';
import 'package:shopera/core/services/google_signin_api.dart';
import 'package:shopera/features/authentication/presentation/cubits/user_cubit/cubit.dart';

class PrimaryButtonGoogle extends StatelessWidget {
  const PrimaryButtonGoogle({super.key ,required BuildContext context});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
                  borderSideColor: Colors.black,
                     onPressed: () async {
                    await GoogleSignInApi.login().then((user) {
                      if (user == null) {
                        SnackBarGlobal.show(
                          context,
                          Faild_Google_SignIn,
                          color: Colors.red,
                          icon: Icons.cancel,
                        );
                      } else {
                        context.read<UserCubit>().loginUser(
                              username: Default_Login_Username,
                              password: Default_Login_Password,
                              isFromGoogle: true,
                            );
                      }
                    });
                  },
                  height: 55,
                  bgColor: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        height: 20,
                        width: 20,
                        'assets/images/svg/google_logo.svg',
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        'Google',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                );
  }
}