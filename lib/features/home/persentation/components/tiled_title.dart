import 'package:flutter/material.dart';

import 'minimal_text_button.dart';
import 'title_widget.dart';

class TiledTitle extends StatelessWidget {
  const TiledTitle({
    super.key,
    required this.title,
    required this.tileText,
    required this.onTap,
  });
  final String title;
  final String tileText;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TitleWidget(
          label: title,
          fontSize: 16,
        ),
        MinimalTextButton(
          text: tileText,
          textStyle: const TextStyle(),
          onPressed: onTap,
        ),
      ],
    );
  }
}
