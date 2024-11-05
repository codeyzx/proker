import 'package:flutter/material.dart';
import 'package:proker/config/themes/app_colors.dart';

class AppBorderStyles {
  static OutlineInputBorder inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: const BorderSide(color: AppColors.inputBorder),
  );

  static OutlineInputBorder inputFocusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: const BorderSide(color: AppColors.inputFocus),
  );

  static OutlineInputBorder inputEnabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: const BorderSide(color: AppColors.inputBorder),
  );

  static OutlineInputBorder inputErrorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: const BorderSide(color: AppColors.inputError),
  );

  static TextStyle hintTextStyle = const TextStyle(
    fontFamily: 'Manrope',
    fontSize: 14,
    color: AppColors.inputHint,
    fontWeight: FontWeight.w500,
  );
}
