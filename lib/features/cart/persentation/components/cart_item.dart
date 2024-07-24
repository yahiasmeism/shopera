import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopera/core/widgets/app_cached_image.dart';
import '../../../../core/utils/image_cached_manager.dart';
import '../../../../core/widgets/custom_fading_widget.dart';
import 'cart_item_counter.dart';

import '../../../../core/constants/colors.dart';
import '../../domin/entities/cart_item_entity.dart';
import '../cubit/cart_cubit.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({super.key, required this.item});
  final CartItemEntity item;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).highlightColor,
            offset: const Offset(0, 1),
            blurRadius: 3,
            spreadRadius: 2,
          )
        ],
        color: Theme.of(context).cardColor,
      ),
      height: 120,
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
              const SizedBox(width: 12),
              AppCachedImage(imageUrl: item.thumbnail),
            ],
          )
        ],
      ),
    );
  }
}
