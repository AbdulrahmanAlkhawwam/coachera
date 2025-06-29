import 'package:flutter/material.dart';

import 'text_font.dart';

OutlinedButtonThemeData outlineButtonStyle(ColorScheme colors) =>
    OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        maximumSize: Size(double.infinity, 48),
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
        side: BorderSide(color: colors.primary),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        textStyle: textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: colors.onSurface,
        ),
        fixedSize: const Size.fromHeight(48),
      ),
    );
