import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopera/features/home/persentation/cubit/products_cubit.dart';

import '../../features/search/search_page.dart';

class RoundedCategory extends StatelessWidget {
  const RoundedCategory({super.key, required this.imagePath, required this.categoryName});
  final String imagePath;
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, SearchPage.routeName);
        context.read<ProductsCubit>().changeCategory(categoryName);
      },
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 48,
            height: 48,
          ),
          const SizedBox(height: 12.0),
          Text(
            categoryName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
          // SubtitleWidget(
          //   label: categoryName,
          //   fontWeight: FontWeight.bold,
          // ),
        ],
      ),
    );
  }
}
