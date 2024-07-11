import 'package:flutter/material.dart';
import 'package:shopera/core/constants/colors.dart';

ThemeData appTheme() {
  return ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    appBarTheme: const AppBarTheme(
      color: AppColors.backgroundColor,
      elevation: 0,
    ),
    primarySwatch: AppColors.primaryColor,
  );
}
