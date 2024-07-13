import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import 'minimal_text_button.dart';
import 'title_widget.dart';

class TiledTitle extends StatelessWidget {
  const TiledTitle({
    super.key,
    required this.title,
    required this.tileText,
    required this.function,
  });
  final String title;
  final String tileText;
  final VoidCallback function;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TitleWidget(
          label: title,
          color: AppColors.textColor,
          fontSize: 16,
        ),
        MinimalTextButton(
          text: tileText,
          textStyle: const TextStyle(
            color: AppColors.textColor,
          ),
          onPressed: function,
        ),
      ],
    );
  }
}
