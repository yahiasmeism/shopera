import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopera/core/widgets/app_cached_image.dart';
import '../../domin/entities/cart_item.dart';
import 'cart_item_counter.dart';

import '../../../../core/constants/colors.dart';
import '../cubit/cart_cubit.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({super.key, required this.item});
  final CartItem item;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
    return SizedBox(
      height: 140,
      child: Card(
        elevation: 2,
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 200),
                        child: Text(
                          item.title,
                        )),
                    Text(
                      '\$${item.price}',
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: CartItemCounterWidget(
                      initalValue: item.quantity,
                      onChange: (value) {
                        cubit.onChangeQuantitiesOfItem(value, item.id);
                      },
                    ),
                  ),
                  AppCachedImage(imageUrl: item.thumbnail),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
