import '../widgets/settings.dart';
import '../widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cart/persentation/components/cart_button.dart';
import '../../authentication/presentation/cubits/user_cubit/cubit.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = 'settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String? _userEmail;
  String? _userName;
  String? _userImage;

  @override
  void initState() {
    final user = context.read<UserCubit>().userEntite;
    if (user != null) {
      _userImage = user.image;
      _userName = user.userName;
      _userEmail = user.email;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: const [CartButtonWidget()],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              Visibility(
                visible:_userName != null,
                child: ProfileCardWidget(
                  name: _userName?? "",
                  email: _userEmail ?? "",
                  image: _userImage,
                ),
              ),
              SettingsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
