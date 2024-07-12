import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/assets.dart';

class HomePageTopSwiper extends StatelessWidget {
  const HomePageTopSwiper({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.18,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        child: Swiper(
          autoplay: true,
          itemBuilder: (BuildContext context, int index) {
            return Image.asset(
              AppConstants.bannerImages[index],
              fit: BoxFit.cover,
            );
          },
          itemCount: AppConstants.bannerImages.length,
          pagination: const SwiperPagination(
            builder: DotSwiperPaginationBuilder(
                color: Colors.red, activeColor: Colors.blue),
            alignment: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }
}
