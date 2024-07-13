import 'package:flutter/material.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/constants/colors.dart';
import 'appbar_widget.dart';
import 'category_selector.dart';
import 'dynamic_product_card.dart';
import 'search_textfield.dart';
import 'tiled_title.dart';
class PopularProductsPage extends StatefulWidget {
  const PopularProductsPage({super.key, required this.title});
  final String title;

  @override
  State<PopularProductsPage> createState() => _PopularProductsPageState();
}

class _PopularProductsPageState extends State<PopularProductsPage> {
  final  _searchTextController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  void clearSearch() {
    setState(() {
      _searchTextController.clear();
      _searchQuery = '';
    });
    // Implement logic to reset displayed products if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const AppBarWidget(
        title: 'Popular Products',
        suffixIcon: Icons.shopping_cart,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchTextField(
                  controller: _searchTextController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                      // Implement filtering logic or update product list here
                    });
                  },
                  onClear: clearSearch, // Pass clearSearch callback
                ),
                const SizedBox(height: 14),
                const CategorySelector(), // Ensure this widget is implemented properly
                const SizedBox(height: 28),
                TiledTitle(
                  title: 'Popular products for you',
                  tileText: '',
                  function: () {},
                ),
                const SizedBox(height: 14),
                _buildTypeBProduct(), // Display typeB product at the top
                const SizedBox(height: 14),
                _buildTypeAProductGrid(), // Display typeA products in a grid
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeBProduct() {
    // Replace with your logic to fetch typeB product
    Map<String, dynamic> productB = {
      'type': 'typeB',
      'title': 'Headphone Holder',
      'imagePath': AppConstants.productImageUrls[5],
      'price': 36.00,
    };

    return DynamicProductCard(
      type: productB['type'],
      title: productB['title'],
      imagePath: productB['imagePath'],
      price: productB['price'],
    );
  }

  Widget _buildTypeAProductGrid() {
    // Replace with your logic to fetch typeA products
    List<Map<String, dynamic>> productsA = [
      {
        'type': 'typeA',
        'title': 'Aqua Shoes 1',
        'imagePath': AppConstants.productImageUrls[0],
        'price': 36.00,
      },
      {
        'type': 'typeA',
        'title': 'Aqua Shoes 1',
        'imagePath': AppConstants.productImageUrls[0],
        'price': 36.00,
      },
      {
        'type': 'typeA',
        'title': 'Aqua Shoes 2',
        'imagePath': AppConstants.productImageUrls[1],
        'price': 42.00,
      },
      {
        'type': 'typeA',
        'title': 'Aqua Shoes 2',
        'imagePath': AppConstants.productImageUrls[1],
        'price': 42.00,
      },
      {
        'type': 'typeA',
        'title': 'Aqua Shoes 2',
        'imagePath': AppConstants.productImageUrls[1],
        'price': 42.00,
      },
      // Add more typeA products as needed
    ];

    // Filter products based on search query if needed
    if (_searchQuery.isNotEmpty) {
      productsA = productsA
          .where((product) => product['title']
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()))
          .toList();
    }

    // Build grid of typeA products
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.74,
      ),
      itemCount: productsA.length,
      itemBuilder: (context, index) {
        final product = productsA[index];
        return DynamicProductCard(
          type: product['type'],
          title: product['title'],
          imagePath: product['imagePath'],
          price: product['price'],
        );
      },
    );
  }
}
