import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/snackbar_global.dart';
import '../pages/cart_page.dart';

import '../cubit/cart_cubit.dart';

class CartButtonWidget extends StatelessWidget {
  const CartButtonWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartFailure) {
          SnackBarGlobal.show(context, state.message);
        }
      },
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            Navigator.pushNamed(context, CartPage.routeName);
          },
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
