import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../domin/entities/category_entity.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({super.key, required this.categories});
  final List<CategoryEntity> categories;
  @override
  State createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: selectedIndex == index ? AppColors.primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Text(
                    widget.categories[index].name,
                    style: TextStyle(
                      color: selectedIndex == index ? Colors.white : AppColors.textColor,
                      fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
