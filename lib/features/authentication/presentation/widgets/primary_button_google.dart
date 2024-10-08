import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import '../cubits/user_cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/widgets/button_primary.dart';
import '../../../../core/widgets/snackbar_global.dart';
import '../../../../core/services/google_signin_api.dart';

class PrimaryButtonGoogle extends StatelessWidget {
  const PrimaryButtonGoogle({super.key, required BuildContext context});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      borderSideColor: Theme.of(context).dividerColor,
      onPressed: () async {
        try{
 await GoogleSignInApi.login().then((user) {
          if (user == null) {
            SnackBarGlobal.show(
              context,
              Faild_Google_SignIn,
              color: Theme.of(context).colorScheme.error,
              icon: Icons.cancel,
            );
          } else {
            context.read<UserCubit>().signInUser(
                  username: Default_Login_Username,
                  password: Default_Login_Password,
                  isFromGoogle: true,
                );
          }
        });
        } catch(e){
           throw  OfflineException(e.toString());
        }
       
      },
      height: 55,
      bgColor: Theme.of(context).scaffoldBackgroundColor,
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
          Text(
            'Google',
            style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
          ),
        ],
      ),
    );
  }
}
