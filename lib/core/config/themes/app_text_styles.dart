import 'package:flutter/material.dart';
import 'package:proker/core/config/themes/app_colors.dart';
import 'package:proker/core/constants/app_constants.dart';

class AppTextStyles {
  static TextStyle title = const TextStyle(
    fontFamily: AppConstants.defaultFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textDark,
  );

  static TextStyle inputHeader = const TextStyle(
    fontFamily: AppConstants.defaultFontFamily,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
    fontSize: 14,
  );

  static TextStyle inputHeaderRed = const TextStyle(
    fontFamily: AppConstants.defaultFontFamily,
    fontWeight: FontWeight.w600,
    color: AppColors.alertError,
    fontSize: 15,
  );

  static TextStyle inputLabel = const TextStyle(
    fontFamily: AppConstants.defaultFontFamily,
    fontSize: 14,
    color: AppColors.inputLabel,
  );

  static TextStyle body = const TextStyle(
    fontFamily: AppConstants.defaultFontFamily,
    fontSize: 13,
    color: AppColors.textGrey,
  );
}
