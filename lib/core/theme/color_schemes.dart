import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppColorSchemes {
  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.white,
    primaryContainer: AppColors.primarySurface,
    secondary: AppColors.secondary,
    onSecondary: AppColors.white,
    secondaryContainer: AppColors.secondarySurface,
    surface: AppColors.whiteGrey,
    onSurface: AppColors.neutral500,
    error: AppColors.warning,
    onError: AppColors.white,
    outline: AppColors.neutral300,
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primary,
    onPrimary: AppColors.neutral500,
    primaryContainer: AppColors.primarySurface,
    secondary: AppColors.secondary,
    onSecondary: AppColors.neutral500,
    secondaryContainer: AppColors.secondarySurface,
    surface: AppColors.neutral400,
    onSurface: AppColors.white,
    error: AppColors.warning,
    onError: AppColors.white,
    outline: AppColors.neutral300,
  );
}
