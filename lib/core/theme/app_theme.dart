import 'package:coachera/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'app_text_theme.dart';
import 'color_schemes.dart';

class AppTheme {
  static ThemeData get lightTheme =>
      build(colorScheme: AppColorSchemes.lightColorScheme);

  static ThemeData get darkTheme =>
      build(colorScheme: AppColorSchemes.darkColorScheme);

  static ThemeData build({required ColorScheme colorScheme}) {
    final isDark = colorScheme.brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        iconTheme: IconThemeData(
          color: colorScheme.outline,
          size: 24,
        ),
        titleTextStyle: AppTextTheme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600, // SemiBold
          color: colorScheme.onSurface,
        ),
      ),
      textTheme: AppTextTheme.textTheme,
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
          padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
          minimumSize: WidgetStateProperty.all<Size>(Size(42, 42)),
          shape: WidgetStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: AppColors.neutral100),
            ),
          ),
          iconColor: WidgetStateProperty.all<Color>(AppColors.neutral300),
        ),
      ),
      iconTheme: IconThemeData(color: colorScheme.onSurface),
      dividerColor: colorScheme.outlineVariant,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: AppTextTheme.textTheme.bodyMedium
              ?.copyWith(color: colorScheme.onPrimary),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: colorScheme.primaryContainer,
          foregroundColor: colorScheme.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: AppTextTheme.textTheme.bodyMedium
              ?.copyWith(color: colorScheme.onPrimary),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? colorScheme.surface : colorScheme.surfaceVariant,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.primary),
        ),
        labelStyle: TextStyle(color: colorScheme.onSurface),
      ),
    );
  }
}
