
import 'package:shopera/core/services/assets_manager.dart';

class AppConstants {

  static List<CategoryModel> appCategories = [
    CategoryModel(
      id: AssetsManager.book,
      name: 'Books',
      image: AssetsManager.book,
    ),
    CategoryModel(
      id: AssetsManager.fashion,
      name: 'Fashion',
      image: AssetsManager.fashion,
    ),
    CategoryModel(
      id: AssetsManager.shoes,
      name: 'Shoes',
      image: AssetsManager.shoes,
    ),
    CategoryModel(
      id: AssetsManager.electronics,
      name: 'Electronics',
      image: AssetsManager.electronics,
    ),
    CategoryModel(
      id: AssetsManager.mobiles,
      name: 'Phones',
      image: AssetsManager.mobiles,
    ),
    CategoryModel(
      id: AssetsManager.pc,
      name: 'Laptops',
      image: AssetsManager.pc,
    ),
    CategoryModel(
      id: AssetsManager.cosmetics,
      name: 'Cosmetics',
      image: AssetsManager.cosmetics,
    ),
    CategoryModel(
      id: AssetsManager.watch,
      name: 'Watch',
      image: AssetsManager.watch,
    ),
  ];
}

class CategoryModel {
  final String id, name, image;
  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
  });
}