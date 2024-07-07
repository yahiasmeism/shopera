import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class CartItemEntity extends Equatable {
  final int id;
  final String title;
  final double price;
  final int quantity;
  final double total;
  final double discountPercentage;
  final int discountedPrice;
  final String? thumbnail;

  const CartItemEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.total,
    required this.discountPercentage,
    required this.discountedPrice,
    required this.thumbnail,
  });

  CartItemEntity copyWith({
    int? id,
    String? title,
    double? price,
    int? quantity,
    double? total,
    double? discountPercentage,
    int? discountedPrice,
    ValueGetter<String?>? thumbnail,
  }) {
    return CartItemEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      total: total ?? this.total,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      thumbnail: thumbnail != null ? thumbnail() : this.thumbnail,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      title,
      price,
      quantity,
      total,
      discountPercentage,
      discountedPrice,
      thumbnail,
    ];
  }
}
