import 'package:coachera/core/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'color_schemes.dart';

class LightTheme {
  static ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColorSchemes.lightColorScheme,
      textTheme: AppTextTheme.lightTextTheme,

    );
  }
}
