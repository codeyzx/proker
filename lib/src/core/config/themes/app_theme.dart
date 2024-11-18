import 'package:flutter/material.dart';
import 'package:proker/src/core/config/themes/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData data(bool isDark) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.primaryDarker,
        error: AppColors.textRed,
        surfaceTint: Colors.transparent,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        circularTrackColor: Color(0xFFE0E0E0),
        color: AppColors.primary,
      ),
      dividerColor: Colors.transparent,
      fontFamily: 'Poppins',
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          fontFamily: 'Poppins',
          color: AppColors.textBlack,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      scaffoldBackgroundColor: Colors.white,
      textTheme: const TextTheme(
        titleLarge: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color: Colors.red),
        bodyLarge: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
        bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textBlack),
        labelLarge: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w600, color: Colors.blue),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 1,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        showSelectedLabels: true,
      ),
    );
  }
}
