import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onPrefixIconPressed;
  final VoidCallback? onSuffixIconPressed;

  const AppBarWidget({
    super.key,
    required this.title,
    this.prefixIcon,
    this.suffixIcon,
    this.onPrefixIconPressed,
    this.onSuffixIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          prefixIcon,
          color: AppColors.iconColor,
        ),
        onPressed: onPrefixIconPressed,
      ),
      title: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            suffixIcon,
            color: AppColors.iconColor,
          ),
          onPressed: onSuffixIconPressed,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
