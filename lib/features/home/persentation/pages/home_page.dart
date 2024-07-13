import 'package:flutter/material.dart';
import 'package:shopera/features/cart/persentation/components/cart_button.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/constants/colors.dart';
import '../components/category_selector.dart';
import '../components/dynamic_product_card.dart';
import '../components/product_card.dart';
import '../components/tiled_title.dart';
import '../components/top_swiper.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const routeName = 'home';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: const [CartButtonWidget()],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              HomePageTopSwiper(
                size: size,
              ),
              const SizedBox(height: 28),
              TiledTitle(
                title: 'Categories',
                tileText: 'See All',
                function: () {},
              ),
              const SizedBox(height: 14),
              const CategorySelector(),
              const SizedBox(height: 28),
              TiledTitle(
                title: 'Popular products for you',
                tileText: 'See All',
                function: () {},
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                      child: ProductCard(
                    title: 'Aqua Shoes',
                    imagePath: AppConstants.productImageUrls[0],
                  )),
                  const SizedBox(width: 7),
                  Expanded(
                      child: ProductCard(
                    title: 'Softy Headphones',
                    imagePath: AppConstants.productImageUrls[1],
                  )),
                ],
              ),
              const SizedBox(height: 28),
              TiledTitle(
                title: 'Latest Products',
                tileText: 'See All',
                function: () {},
              ),
              const SizedBox(height: 14),
              DynamicProductCard(
                  type: 'typeC',
                  imagePath: AppConstants.productImageUrls[0],
                  title: 'Title goes here',
                  price: 33.9),
              const SizedBox(height: 7),
              DynamicProductCard(
                  type: 'typeC',
                  imagePath: AppConstants.productImageUrls[5],
                  title: 'Title goes here',
                  price: 33.9),
              const SizedBox(height: 7),
              DynamicProductCard(
                  type: 'typeC',
                  imagePath: AppConstants.productImageUrls[4],
                  title: 'Title goes here',
                  price: 33.9),
              const SizedBox(height: 7),
              DynamicProductCard(
                  type: 'typeC',
                  imagePath: AppConstants.productImageUrls[2],
                  title: 'Title goes here',
                  price: 33.9),
              const SizedBox(height: 7),
              DynamicProductCard(
                  type: 'typeC',
                  imagePath: AppConstants.productImageUrls[3],
                  title: 'Title goes here',
                  price: 33.9),
              const SizedBox(height: 7),
              DynamicProductCard(
                  type: 'typeC',
                  imagePath: AppConstants.productImageUrls[0],
                  title: 'Title goes here',
                  price: 33.9),
              const SizedBox(height: 7),
              DynamicProductCard(
                  type: 'typeC',
                  imagePath: AppConstants.productImageUrls[1],
                  title: 'Title goes here',
                  price: 33.9),
              const SizedBox(height: 7),
            ],
          ),
        ),
      ),
    );
  }
}
