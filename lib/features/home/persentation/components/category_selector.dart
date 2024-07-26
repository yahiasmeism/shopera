import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../domin/entities/category_entity.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({
    super.key,
    required this.categories,
    required this.selectedValue,
    this.initialCategory,
  });

  final List<CategoryEntity> categories;
  final Function(String value) selectedValue;
  final String? initialCategory;

  @override
  State createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int selectedIndex = 0;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    if (widget.initialCategory != null) {
      selectedIndex = widget.categories.indexWhere((category) => category.name == widget.initialCategory);
      if (selectedIndex == -1) {
        selectedIndex = 0; // fallback to the first category if not found
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedIndex();
    });
  }

  void _scrollToSelectedIndex() {
    _scrollController.animateTo(
      selectedIndex * 100.0, // تقدير العرض بناءً على العرض التقديري لكل عنصر
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                    widget.selectedValue(widget.categories[index].name);
                  });
                  _scrollToSelectedIndex();
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: selectedIndex == index ? AppColors.primaryColor : Theme.of(context).highlightColor,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Text(
                    widget.categories[index].name,
                    style: TextStyle(
                      color: selectedIndex == index
                          ? Theme.of(context).scaffoldBackgroundColor
                          : Theme.of(context).textTheme.bodyLarge?.color,
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
