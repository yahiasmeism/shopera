import 'package:flutter/material.dart';
import 'package:shopera/core/constants/colors.dart';

ThemeData appLightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor, brightness: Brightness.light),
  cardTheme: const CardTheme(color: AppColors.backgroundColor),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.backgroundColor,
    centerTitle: true,
    elevation: 0,
  ),

  // Define other light theme properties
  scaffoldBackgroundColor: AppColors.backgroundColor,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.backgroundColor,
    selectedItemColor: AppColors.primaryColor,
    unselectedItemColor: AppColors.iconColor,
  ),
);

ThemeData appDarkTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    elevation: 0,
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor, brightness: Brightness.dark),

  // Define other dark theme properties
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.backgroundColor,
    selectedItemColor: AppColors.primaryColor,
    unselectedItemColor: AppColors.iconColor,
  ),
);
