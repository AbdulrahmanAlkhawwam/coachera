import 'package:flutter/material.dart';

import 'text_font.dart';

appBarStyle(ColorScheme colors) => AppBarTheme(
      backgroundColor: colors.surface,
      foregroundColor: colors.onSurface,
      elevation: 0.0,
      titleTextStyle: textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w600, // SemiBold
        color: colors.onSurface,
      ),
    );
