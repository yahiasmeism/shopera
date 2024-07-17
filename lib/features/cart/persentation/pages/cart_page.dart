import '../components/cart_body.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  static const routeName = 'cart page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: const CartBodyWidget(),
    );
  }
}
