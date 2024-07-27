import 'dynamic_product_card.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domin/entities/product_entity.dart';
import '../../../cart/persentation/cubit/cart_cubit.dart';
import '../../../favorite/data/models/favorite_model.dart';
import '../../../favorite/presentation/favorite_cubit.dart';
import '../../../favorite/presentation/favorite_state.dart';

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
          builder: (context, cartState) {
            final id = products[index].id;
<<<<<<< HEAD
            return DynamicProductCard(
              isAddedToCart: cartCubit.containsItem(id),
              toggleCart: () {
                if (!cartCubit.containsItem(id)) {
                  cartCubit.addItem(id);
                } else {
                  cartCubit.deleteItem(id);
                }
=======
            return BlocBuilder<FavoriteCubit, FavoriteState>(
              builder: (context, favoriteState) {
                return DynamicProductCard(
                  isAddedToCart: cartCubit.continItem(id),
                  toggleCart: () {
                    if (!cartCubit.continItem(id)) {
                      cartCubit.addItem(id);
                    } else {
                      cartCubit.deleteItem(id);
                    }
                  },
                  isFavorite: favoriteCubit.isFavorite(id),
                  toggleFavorite: () {
                    final product = FavoriteModel(
                      id: id,
                      title: products[index].title,
                      description: products[index].description,
                      price: products[index].price,
                      discountPercentage: products[index].discountPercentage,
                      images: products[index].thumbnail,
                    );
                    if (!favoriteCubit.isFavorite(id)) {
                      favoriteCubit.addFavorite(product);
                    } else {
                      favoriteCubit.removeFavorite(id);
                    }
                  },
                  type: 'typeA',
                  product: products[index],
                );
>>>>>>> 8013ddcb1460065202ec422d9c70fe706afbfd18
              },
            );
          },
        );
      },
    );
  }
}
