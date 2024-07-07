import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopera/features/cart/persentation/cubit/cart_cubit.dart';
import 'package:shopera/features/cart/persentation/widgets/cart_sliver_list_view.dart';
import 'package:shopera/features/cart/persentation/widgets/cart_statistics_widget.dart';

import '../../../../core/widgets/button_primary.dart';

class CartBodyWidget extends StatelessWidget {
  const CartBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            if (state is CartLoaded)
              CartItemSliverListView(items: state.cart.items),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CartStatisticsWidget(
                        cart: state is CartLoaded ? state.cart : null,
                      ),
                      PrimaryButton(
                        labelText: 'Checkout',
                        margin: const EdgeInsets.symmetric(vertical: 14),
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        onPressed:
                            state is CartLoaded && state.cart.items.isNotEmpty
                                ? () {}
                                : null,
                      ),
                    ],
                  )),
            ),
          ],
        );
      },
    );
  }
}
