import 'package:hive/hive.dart';


part 'favorite_model.g.dart';

@HiveType(typeId: 1)
class FavoriteModel extends HiveObject{
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final double price;
  @HiveField(4)
  final double discountPercentage;
  @HiveField(5)
  final List<String> images;

  FavoriteModel({required this.id, required this.title, required this.description, required this.price, required this.discountPercentage, required this.images});
}
