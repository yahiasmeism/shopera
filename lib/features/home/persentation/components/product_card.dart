

import 'package:flutter/material.dart';
import 'package:shopera/features/home/persentation/components/title_widget.dart';

import '../../../../core/constants/colors.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.imagePath, required this.title});
  final String imagePath;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
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
                    label: title,
                    fontSize: 16,
                  ),
                  const SizedBox(height: 7),
                  _buildPriceAndActions(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(14.0)),
      child: Image.network(
        imagePath,
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
        const Text(
          '\$36.00',
          style: TextStyle(
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

