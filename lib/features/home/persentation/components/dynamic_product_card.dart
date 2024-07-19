import 'package:flutter/material.dart';

import 'package:shopera/features/home/domin/entities/product_entity.dart';

import '../../../../core/constants/colors.dart';
import 'product_image.dart';
import 'title_widget.dart';

class DynamicProductCard extends StatelessWidget {
  final ProductEntity product;
  final String type;
  final double? height;

  const DynamicProductCard({
    super.key,
    required this.product,
    required this.type,
    this.height = 100,
  });

  @override
  Widget build(BuildContext context) {
    Widget productCard;

    switch (type) {
      case 'typeA':
        productCard = _buildTypeA();
        break;
      case 'typeB':
        productCard = _buildTypeB();
        break;
      case 'typeC':
        productCard = _buildTypeC();
        break;
      default:
        throw ArgumentError('Invalid product type: $type');
    }

    return productCard;
  }

  Widget _buildTypeA() {
    return Card(
      color: AppColors.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      elevation: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildImage(),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleWidget(
                  label: product.title,
                  fontSize: 16,
                ),
                const SizedBox(height: 7),
                _buildPriceAndActions(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeB() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: height,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(product.thumbnail),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    product.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '\$${product.price}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: const Icon(
                          Icons.favorite_border,
                          size: 20,
                          color: Colors.teal,
                        ),
                        onPressed: () {
                          // Handle favorite button press
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Handle add to cart button press
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    child: const Text(
                      'ADD TO CART',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeC() {
    return Card(
      color: AppColors.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      elevation: 2,
      child: SizedBox(
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14.0),
                child: ProductImage(imageUrl: product.thumbnail, height: 150),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TitleWidget(
                      label: product.title,
                      fontSize: 16,
                    ),
                    Text(
                      '\$${product.price}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.priceColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.favorite_border,
                      size: 20,
                      color: AppColors.iconColor,
                    ),
                    onPressed: () {
                      // Handle favorite button press
                    },
                  ),
                  const SizedBox(width: 7),
                  IconButton(
                    icon: const Icon(
                      Icons.shopping_cart,
                      size: 20,
                      color: AppColors.iconColor,
                    ),
                    onPressed: () {
                      // Handle shopping cart button press
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(14.0)),
      child: ProductImage(
        imageUrl: product.thumbnail,
        height: 150,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildPriceAndActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '\$${product.price}',
          style: const TextStyle(
            fontSize: 18,
            color: AppColors.priceColor,
          ),
        ),
        Row(
          children: [
            _buildIconButton(Icons.favorite_border, () {}),
            _buildIconButton(Icons.shopping_cart, () {}),
          ],
        ),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(
        icon,
        size: 20,
        color: AppColors.iconColor,
      ),
      onPressed: onPressed,
    );
  }
}
