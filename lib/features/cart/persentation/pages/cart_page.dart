import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopera/features/cart/persentation/cubit/cart_cubit.dart';

import '../components/cart_body.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  static const routeName = 'cart page';
  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              if (cartCubit.cart != null)
                IconButton(
                  onPressed: () {
                    context.read<CartCubit>().removeCart();
                  },
                  icon: const Icon(Icons.cancel, size: 30.0),
                )
            ],
            title: const Text('Cart'),
            centerTitle: true,
          ),
          body: const CartBodyWidget(),
        );
      },
    );
  }
}
