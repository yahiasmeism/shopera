import '../../home/data/models/product_model.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoritesLoaded extends FavoriteState {
  final List<ProductModel> favorites;

  FavoritesLoaded(this.favorites);
}
