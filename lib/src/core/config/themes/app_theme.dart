import 'package:flutter/material.dart';
import 'package:proker/src/core/config/themes/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData data(bool isDark) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: isDark
          ? const ColorScheme.dark(
              primary: AppColors.darkPrimary,
              secondary: AppColors.darkPrimaryDarker,
              error: AppColors.darkTextRed,
              surfaceTint: Colors.transparent,
            )
          : ColorScheme.light(
              primary: AppColors.primary,
              secondary: AppColors.primaryDarker,
              error: AppColors.textRed,
              surfaceTint: Colors.transparent,
            ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        circularTrackColor:
            isDark ? AppColors.darkTextGrey : const Color(0xFFE0E0E0),
        color: isDark ? AppColors.darkPrimary : AppColors.primary,
      ),
      dividerColor: Colors.transparent,
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(
          isDark ? AppColors.bgWhite : AppColors.primary,
        ),
        trackColor: WidgetStateProperty.all(
          isDark ? AppColors.darkPrimaryDarker : Colors.white,
        ),
      ),
      fontFamily: 'Poppins',
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? AppColors.darkBackground : Colors.white,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          fontFamily: 'Poppins',
          color: isDark ? AppColors.darkTextWhite : AppColors.textBlack,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      iconTheme: IconThemeData(
        color: isDark
            ? AppColors.darkTextWhite
            : AppColors.textBlack.withOpacity(0.4),
      ),
      scaffoldBackgroundColor: isDark ? AppColors.darkBackground : Colors.white,
      textTheme: TextTheme(
        titleLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.darkTextRed : Colors.red),
        bodyLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.darkTextWhite : Colors.black),
        bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.darkTextWhite : AppColors.textBlack),
        labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.darkTextGrey : Colors.blue),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 1,
        backgroundColor: isDark ? AppColors.darkBackground : Colors.white,
        selectedItemColor: isDark ? AppColors.bgWhite : AppColors.primary,
        unselectedItemColor: isDark ? AppColors.darkTextGrey : Colors.grey,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        selectedLabelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
