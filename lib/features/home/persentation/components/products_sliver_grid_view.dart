import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cart/persentation/cubit/cart_cubit.dart';
import '../../domin/entities/product_entity.dart';
import 'dynamic_product_card.dart';

class ProductSliverGridView extends StatelessWidget {
  const ProductSliverGridView({super.key, required this.products});
  final List<ProductEntity> products;
  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();

    return SliverGrid.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 7,
        crossAxisSpacing: 7,
        childAspectRatio: 0.67,
      ),
      itemBuilder: (context, index) {
        return BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            final id = products[index].id;
            return DynamicProductCard(
              isAddedToCart: cartCubit.containsItem(id),
              toggleCart: () {
                if (!cartCubit.containsItem(id)) {
                  cartCubit.addItem(id);
                } else {
                  cartCubit.deleteItem(id);
                }
              },
              toggleFavorite: () {},
              type: 'typeA',
              product: products[index],
            );
          },
        );
      },
    );
  }
}
