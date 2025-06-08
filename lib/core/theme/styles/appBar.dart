import 'package:flutter/material.dart';

import 'text_font.dart';

appBarStyle(ColorScheme colors) => AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: colors.onSurface,
      elevation: 0.0,
      actionsPadding: EdgeInsets.symmetric(horizontal: 12),
      titleTextStyle: textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w600, // SemiBold
        color: colors.onSurface,
      ),
    );
