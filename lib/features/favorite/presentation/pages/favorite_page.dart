import '../favorite_cubit.dart';
import '../favorite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/app_cached_image.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoritesLoaded) {
            final favoriteProducts = state.favorites;
            if (favoriteProducts.isEmpty) {
              return const Center(child: Text('No favorites yet.'));
            }
            return ListView.builder(
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Theme.of(context).highlightColor, width: 2), // Border color and width
                    borderRadius: BorderRadius.circular(10), // Border radius
                  ),
                  child: ListTile(
                    leading: AppCachedImage(imageUrl: product.thumbnail, height: 50),
                    title: Text(product.title),
                    subtitle: Text('\$ ${product.price}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        context.read<FavoriteCubit>().removeFavorite(product.id);
                      },
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
