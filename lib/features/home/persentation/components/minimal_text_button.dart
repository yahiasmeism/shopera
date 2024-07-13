import 'package:flutter/material.dart';

class MinimalTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final TextStyle textStyle;
  final BoxConstraints constraints;

  const MinimalTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.textStyle,
    this.constraints = const BoxConstraints(minWidth: 50, minHeight: 20),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: constraints,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}
