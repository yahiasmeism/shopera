import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:shopera/core/constants/colors.dart';

class PrimaryLoadingButton extends StatelessWidget {
  const PrimaryLoadingButton({
    super.key,
    required this.labelText,
    this.onPressed,
    this.buttonColor,
  });
  final String labelText;
  final Function()? onPressed;
  final Color? buttonColor;
  @override
  Widget build(BuildContext context) {
    return EasyButton(
      idleStateWidget: Text(
        labelText,
        style: TextStyle(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
      loadingStateWidget: CircularProgressIndicator(
        strokeWidth: 4.0,
        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).scaffoldBackgroundColor),
      ),
      useWidthAnimation: true,
      useEqualLoadingStateWidgetDimension: true,
      height: 50.0,
      borderRadius: 28.0,
      contentGap: 10.0,
      buttonColor: buttonColor ?? AppColors.primaryColor,
      onPressed: onPressed,
    );
  }
}
