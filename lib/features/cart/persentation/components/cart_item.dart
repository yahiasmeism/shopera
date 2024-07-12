import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopera/core/utils/image_cached_manager.dart';
import 'package:shopera/core/widgets/custom_fading_widget.dart';
import 'package:shopera/features/cart/persentation/components/cart_item_counter.dart';

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
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(10, 0, 0, 0),
            offset: Offset(0, 1),
            blurRadius: 3,
            spreadRadius: 2,
          )
        ],
        color: Colors.white,
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
              ItemImage(item: item),
            ],
          )
        ],
      ),
    );
  }
}

class ItemImage extends StatelessWidget {
  const ItemImage({
    super.key,
    required this.item,
  });

  final CartItemEntity item;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: FutureBuilder(
        future: ImageCacheManager.getImagePath(item.thumbnail!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              height: 90,
              width: 90,
              child: Image.file(snapshot.data!),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomFadingWidget(
                child: Container(
              height: 90,
              width: 90,
              color: Colors.grey,
            ));
          } else {
            return const Icon(Icons.hide_image);
          }
        },
      ),
    );
  }
}
