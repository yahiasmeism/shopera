import 'package:shopera/features/home/data/models/product_model.dart';
import 'package:shopera/features/home/domin/entities/product_entity.dart';

import 'favorite_state.dart';
import 'package:hive/hive.dart';
import '../../../core/constants/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  late Box<ProductModel> _box;
  FavoriteCubit() : super(FavoriteInitial()) {
    _box = Hive.box(kFavoriteBox);
  }

  void loadFavorites() {
    emit(FavoritesLoaded(_box.values.toList()));
  }

  void addFavorite(ProductEntity productEntity) {
    final productModel = ProductModel(
      id: productEntity.id,
      title: productEntity.title,
      description: productEntity.description,
      category: productEntity.category,
      price: productEntity.price,
      discountPercentage: productEntity.discountPercentage,
      rating: productEntity.rating,
      brand: productEntity.brand,
      thumbnail: productEntity.thumbnail,
      images: productEntity.images,
    );
    _box.put(productEntity.id, productModel);
    emit(FavoritesLoaded(_box.values.toList()));
  }

  void removeFavorite(int productId) {
    _box.delete(productId);
    emit(FavoritesLoaded(_box.values.toList()));
  }

  bool isFavorite(int productId) {
    return _box.containsKey(productId);
  }
}
