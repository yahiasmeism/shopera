import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopera/features/favorite/presentation/favorite_cubit.dart';

import '../../../cart/persentation/cubit/cart_cubit.dart';
import '../../domin/entities/product_entity.dart';
import 'dynamic_product_card.dart';

class ProductSliverGridView extends StatelessWidget {
  const ProductSliverGridView({super.key, required this.products});
  final List<ProductEntity> products;
  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    final favoriteCubit = context.read<FavoriteCubit>();

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
            final product = products[index];
            return DynamicProductCard(
              isFavorite: favoriteCubit.isFavorite(product.id),
              isAddedToCart: cartCubit.containsItem(product.id),
              toggleCart: () => toggleCart(cartCubit, product.id),
              toggleFavorite: (value) => toggleFavorite(favoriteCubit, value, product),
              type: 'typeA',
              product: products[index],
            );
          },
        );
      },
    );
  }

  toggleCart(CartCubit cubit, int id) {
    if (!cubit.containsItem(id)) {
      cubit.addItem(id);
    } else {
      cubit.deleteItem(id);
    }
  }

  toggleFavorite(FavoriteCubit cubit, bool value, ProductEntity product) {
    if (value) {
      cubit.addFavorite(product);
    } else {
      cubit.removeFavorite(product.id);
    }
  }
}
