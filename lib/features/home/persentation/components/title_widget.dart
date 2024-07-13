import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.label,
    this.maxLines,
    this.color,
    this.fontSize = 24, 
  });
  final String label;
  final Color? color;
  final double fontSize;
  final int? maxLines;
  @override
  Widget build(BuildContext context) => Text(
        label,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis,
        ),
        maxLines: maxLines,
      );
}
