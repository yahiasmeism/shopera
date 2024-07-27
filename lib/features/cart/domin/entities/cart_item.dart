import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
part 'cart_item.g.dart';

@HiveType(typeId: 15)
class CartItem extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final double price;
  @HiveField(3)
  final int quantity;
  @HiveField(4)
  final double total;
  @HiveField(5)
  final double discountPercentage;
  @HiveField(6)
  final int discountedPrice;
  @HiveField(7)
  final String? thumbnail;

  const CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.total,
    required this.discountPercentage,
    required this.discountedPrice,
    required this.thumbnail,
  });

  CartItem copyWith({
    int? id,
    String? title,
    double? price,
    int? quantity,
    double? total,
    double? discountPercentage,
    int? discountedPrice,
    ValueGetter<String?>? thumbnail,
  }) {
    return CartItem(
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
