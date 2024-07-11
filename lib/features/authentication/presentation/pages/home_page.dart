import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopera/core/widgets/button_primary.dart';
import 'package:shopera/features/cart/persentation/cubit/cart_cubit.dart';
import 'package:shopera/features/cart/persentation/widgets/cart_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const routeName = 'home';

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
    return Scaffold(
      appBar: AppBar(
        actions: const [CartButtonWidget()],
      ),
      body: Center(
        child: PrimaryButton(
          labelText: 'add item',
          onPressed: () {
            cubit.addItem(userId: 1, productId: Random().nextInt(30));
          },
        ),
      ),
    );
  }
}
