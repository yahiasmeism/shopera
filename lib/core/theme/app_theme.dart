import 'package:flutter/material.dart';
import 'package:shopera/core/constants/colors.dart';

ThemeData appLightTheme = ThemeData(
  primarySwatch: AppColors.primaryColor,
  brightness: Brightness.light,
  // Define other light theme properties
  scaffoldBackgroundColor:AppColors.backgroundColor,
   bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.backgroundColor,
          selectedItemColor: AppColors.primaryColor,  
          unselectedItemColor: AppColors.iconColor,
        ),
);

ThemeData appDarkTheme = ThemeData(
  primarySwatch: AppColors.primaryColor,
  brightness: Brightness.dark,
  // Define other dark theme properties
   bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.backgroundColor,
          selectedItemColor: AppColors.primaryColor,  
          unselectedItemColor: AppColors.iconColor,
        ),
);
