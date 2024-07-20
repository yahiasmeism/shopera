import 'package:flutter/material.dart';

import '../constants/colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    this.labelText,
    this.textColor,
    this.bgColor = AppColors.primaryColor,
    this.borderSideColor = Colors.transparent,
    this.borderRadius = 100,
    this.height = 45.0,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.border,
    this.child,
  }) : assert(labelText == null || child == null);

  final String? labelText;
  final Widget? child;
  final Color? textColor;
  final Color bgColor;
  final Color borderSideColor;
  final double borderRadius;
  final double height;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final BoxBorder? border;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      margin: margin,
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius),
              ),
              side: BorderSide(color: borderSideColor),
            ),
          ),
          backgroundColor: onPressed == null
              ? WidgetStateProperty.resolveWith((states) => bgColor.withOpacity(0.3))
              : WidgetStateProperty.resolveWith((states) => bgColor),
          textStyle: WidgetStateProperty.resolveWith(
            (states) => TextStyle(
              color: textColor,
            ),
          ),
        ),
        onPressed: onPressed,
        child: child ??
            Text(
              labelText ?? "",
              style: TextStyle(
                  fontWeight: FontWeight.normal, color: textColor ?? Theme.of(context).scaffoldBackgroundColor, fontSize: 16),
            ),
      ),
    );
  }
}
