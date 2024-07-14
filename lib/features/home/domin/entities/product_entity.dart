import 'package:equatable/equatable.dart';

import 'category_entity.dart';

class ProductEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final List<String> tags;
  final String brand;
  final CategoryEntity category;
  final List<String> images;
  final String thumbnail;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.tags,
    required this.brand,
    required this.thumbnail,
    required this.images,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        category,
        price,
        discountPercentage,
        rating,
        tags,
        brand,
        thumbnail,
        images,
      ];
}
