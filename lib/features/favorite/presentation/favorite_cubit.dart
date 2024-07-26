import 'favorite_state.dart';
import 'package:hive/hive.dart';
import '../data/models/favorite_model.dart';
import '../../../core/constants/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FavoriteCubit extends Cubit<FavoriteState> {

  late Box<FavoriteModel> _box;
  FavoriteCubit() : super(FavoriteInitial()){
    _box =Hive.box(kFavoriteBox);
  }
  
  void loadFavorites() {
    emit(FavoritesLoaded(_box.values.toList()));
  }

  void addFavorite(FavoriteModel product) {
    _box.put(product.id, product);
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


// class FavoriteCubit extends Cubit<FavoriteState> {
//   final Box<FavoriteModel> favoriteBox;

//   FavoriteCubit() : favoriteBox = Hive.box<FavoriteModel>(kFavoriteBox), super(FavoriteInitial());

//   void toggleFavorite(FavoriteModel product) {
//     if (favoriteBox.containsKey(product.id)) {
//       favoriteBox.delete(product.id);
//     } else {
//       favoriteBox.put(product.id, product);
//     }
//     emit(FavoriteUpdated(favoriteBox.values.toList()));
//   }

//   List<FavoriteModel> get favorites => favoriteBox.values.toList();
// }
