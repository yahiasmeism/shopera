import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';

import '../../../../core/widgets/custom_fading_widget.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    this.imageUrl,
    this.height = 150,
    this.width,
    this.fit = BoxFit.cover,
  });

  final String? imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    if (imageUrl != null) {
      return CachedNetworkImage(
        errorWidget: (context, url, error) {
          return _buildPlaceHolderImageWithError();
        },
        placeholder: (context, url) {
          return CustomFadingWidget(
            child: Container(
              color: Colors.grey,
              height: height,
              width: width,
            ),
          );
        },
        imageUrl: imageUrl!,
        fit: fit,
        width: width,
        height: height,
      );
    } else {
      return _buildPlaceHolderImageWithError();
    }
  }

  Container _buildPlaceHolderImageWithError() {
    return Container(
      width: width,
      height: height,
      color: Colors.grey,
      child: const Icon(
        Icons.hide_image,
        size: 100,
        color: AppColors.iconColor,
      ),
    );
  }
}
