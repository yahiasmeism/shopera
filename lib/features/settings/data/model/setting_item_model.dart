import 'package:flutter/material.dart';

class SettingItem {
  final String title;
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback? onTap;
  final Widget? trailing;

  SettingItem({
    required this.title,
    required this.icon,
    required this.backgroundColor,
    this.onTap,
    this.trailing,
  });
}
