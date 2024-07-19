import 'package:flutter/material.dart';
import 'package:shopera/core/constants/colors.dart';

ThemeData appLightTheme = ThemeData(
  primarySwatch: AppColors.primaryColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.backgroundColor,
    centerTitle: true,
    elevation: 0,
  ),

  brightness: Brightness.light,
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

  primarySwatch: AppColors.primaryColor,
  brightness: Brightness.dark,
  // Define other dark theme properties
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.backgroundColor,
    selectedItemColor: AppColors.primaryColor,
    unselectedItemColor: AppColors.iconColor,
  ),
);
