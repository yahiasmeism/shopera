import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cart_cubit.dart';

class CartButtonWidget extends StatelessWidget {
  const CartButtonWidget({
    super.key,
    required this.onPressed,
  });
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return IconButton(
          onPressed: onPressed,
          icon: Stack(
            children: [
              const Icon(Icons.shopping_cart_outlined),
              if (state is CartLoaded && state.cart.items.isNotEmpty)
                const Positioned(
                  right: 0,
                  top: 0,
                  child: Icon(
                    Icons.circle,
                    color: Colors.red,
                    size: 8,
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
