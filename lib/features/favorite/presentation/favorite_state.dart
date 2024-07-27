import '../data/models/favorite_model.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoritesLoaded extends FavoriteState {
  final List<FavoriteModel> favorites;

  FavoritesLoaded(this.favorites);
}
