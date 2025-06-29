import 'package:flutter/material.dart';

import 'text_font.dart';

FilledButtonThemeData filledButtonStyle(ColorScheme colors) => FilledButtonThemeData(
      style: FilledButton.styleFrom(
        maximumSize: Size(double.infinity, 48),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        textStyle: textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: colors.onPrimary,
        ),
        fixedSize: const Size.fromHeight(48),
      ),
    );
