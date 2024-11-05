import 'package:flutter/material.dart';
import 'package:proker/config/themes/app_colors.dart';
import 'package:proker/utils/contants/app_constants.dart';

abstract class AppTheme {
  static ThemeData get light {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: AppColors.bgWhite,
      ),
      scaffoldBackgroundColor: AppColors.bgWhite,
      primaryColor: AppColors.primary,
      splashColor: Colors.transparent,
      fontFamily: AppConstants.defaultFontFamilyLightMode,
      useMaterial3: true,
    );
  }

  static ThemeData get dark {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: AppColors.primary,
      ),
      scaffoldBackgroundColor: AppColors.text,
      primaryColor: AppColors.primary,
      splashColor: Colors.transparent,
      fontFamily: AppConstants.defaultFontFamilyDarkMode,
      useMaterial3: true,
    );
  }
}
