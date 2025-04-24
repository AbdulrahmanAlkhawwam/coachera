import 'package:coachera/core/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'color_schemes.dart';

class DarkTheme {
  static ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColorSchemes.darkColorScheme,
      textTheme: AppTextTheme.darkTextTheme,
    );
  }
}
