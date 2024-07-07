import 'package:flutter/material.dart';

import '../widgets/cart_body.dart';

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
      backgroundColor: const Color(0xffFAFAFA),
      body: const CartBodyWidget(),
    );
  }
}
