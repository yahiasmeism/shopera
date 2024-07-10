import 'package:flutter/material.dart';
import 'package:shopera/core/widgets/button_primary.dart';
import 'package:shopera/features/authentication/presentation/pages/update_user_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  Center(child: Column(
        children: [
          PrimaryButton(
            labelText: "update profile",
            onPressed: () {
            
            Navigator.of(context).pushNamed(UpdateUserPage.routeName);
          },),
          const Text("Home Page"),
        ],
      ),),
    );
  }
}
