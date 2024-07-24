import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/cart_cubit.dart';
import 'cart_sliver_list_view.dart';
import 'cart_statistics_widget.dart';

import '../../../../core/widgets/button_primary.dart';

class CartBodyWidget extends StatelessWidget {
  const CartBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            if (cubit.cart != null) CartItemSliverListView(items: cubit.cart!.items),
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
                        onPressed: state is CartLoaded && state.cart.items.isNotEmpty ? () {} : null,
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
