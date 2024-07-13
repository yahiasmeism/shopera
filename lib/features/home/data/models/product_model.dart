import 'dart:convert';

class ProductModel {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final List<String> tags;
  final String brand;
  final List<String> images;
  final String thumbnail;

  factory ProductModel.fromMap(Map<String, dynamic> data) => ProductModel(
        id: data['id'] as int? ?? 0,
        title: data['title'] as String? ?? '',
        description: data['description'] as String? ?? '',
        category: data['category'] as String? ?? '',
        price: (data['price'] as num? ?? 0).toDouble(),
        discountPercentage: (data['discountPercentage'] as num? ?? 0).toDouble(),
        rating: (data['rating'] as num? ?? 0).toDouble(),
        tags: data['tags'] as List<String>? ?? [],
        brand: data['brand'] as String? ?? '',
        images: data['images'] as List<String>? ?? [],
        thumbnail: data['thumbnail'] as String? ?? '',
      );

  ProductModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.category,
      required this.price,
      required this.discountPercentage,
      required this.rating,
      required this.tags,
      required this.brand,
      required this.images,
      required this.thumbnail});

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category,
        'price': price,
        'discountPercentage': discountPercentage,
        'rating': rating,
        'tags': tags,
        'brand': brand,
        'images': images,
        'thumbnail': thumbnail,
      };

  factory ProductModel.fromJson(String data) {
    return ProductModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}
