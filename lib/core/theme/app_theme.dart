import 'package:flutter/material.dart';

import '../constants/colors.dart';

ThemeData appTheme() {
  return ThemeData(
    useMaterial3: false,
    primarySwatch: AppColors.primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundColor,
      centerTitle: true,
      elevation: 0,
    ),
    scaffoldBackgroundColor: AppColors.backgroundColor,
  );
}
