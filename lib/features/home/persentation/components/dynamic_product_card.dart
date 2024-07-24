import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_cached_image.dart';
import '../../domin/entities/product_entity.dart';
import 'title_widget.dart';

class DynamicProductCard extends StatefulWidget {
  final ProductEntity product;
  final String type;
  final double height;
  final bool isFavorite;
  final bool isAddedToCart;
  final Function() toggleFavorite;
  final Function() toggleCart;
  const DynamicProductCard({
    super.key,
    required this.product,
    required this.type,
    this.height = 100,
    this.isFavorite = false,
    this.isAddedToCart = false,
    required this.toggleFavorite,
    required this.toggleCart,
  });

  @override
  State createState() => _DynamicProductCardState();
}

class _DynamicProductCardState extends State<DynamicProductCard> {
  @override
  Widget build(BuildContext context) {
    Widget productCard;

    switch (widget.type) {
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
        throw ArgumentError('Invalid product type: ${widget.type}');
    }

    return productCard;
  }

  Widget _buildTypeA() {
    return Card(
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
                TitleWidget(label: widget.product.title, fontSize: 16, maxLines: 2),
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
              width: widget.height,
              height: widget.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(widget.product.thumbnail),
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
                    widget.product.title,
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
                        '\$${widget.product.price}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (Widget child, Animation<double> animation) {
                            return ScaleTransition(scale: animation, child: child);
                          },
                          child: Icon(
                            widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                            key: ValueKey<bool>(widget.isFavorite),
                            color: Colors.teal,
                            size: 20,
                          ),
                        ),
                        onPressed: widget.toggleFavorite,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: widget.toggleCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.isAddedToCart ? Colors.grey : Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        widget.isAddedToCart ? 'ADDED' : 'ADD TO CART',
                        key: ValueKey<bool>(widget.isAddedToCart),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
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
        height: widget.height,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14.0),
                child: AppCachedImage(imageUrl: widget.product.thumbnail, height: 150),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TitleWidget(
                      label: widget.product.title,
                      fontSize: 16,
                    ),
                    Text(
                      '\$${widget.product.price}',
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
                  GestureDetector(
                    onTap: widget.toggleFavorite,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: Icon(
                        widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                        key: ValueKey<bool>(widget.isFavorite),
                        color: widget.isFavorite ? Colors.red : AppColors.iconColor,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 7),
                  IconButton(
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        widget.isAddedToCart ? Icons.check : Icons.shopping_cart,
                        key: ValueKey<bool>(widget.isAddedToCart),
                        color: widget.isAddedToCart ? Colors.green : AppColors.iconColor,
                        size: 20,
                      ),
                    ),
                    onPressed: widget.toggleCart,
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
      child: AppCachedImage(
        imageUrl: widget.product.thumbnail,
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
          '\$${widget.product.price}',
          style: const TextStyle(
            fontSize: 18,
            color: AppColors.priceColor,
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: widget.toggleFavorite,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: Icon(
                  widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                  key: ValueKey<bool>(widget.isFavorite),
                  color: widget.isFavorite ? Colors.red : AppColors.iconColor,
                  size: 25,
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: widget.toggleCart,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  widget.isAddedToCart ? Icons.check : Icons.add_shopping_cart_sharp,
                  key: ValueKey<bool>(widget.isAddedToCart),
                  color: widget.isAddedToCart ? Colors.green : AppColors.iconColor,
                  size: 25,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
