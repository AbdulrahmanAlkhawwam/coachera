import 'package:flutter/material.dart';

import 'text_font.dart';

ElevatedButtonThemeData elevatedButtonStyle(ColorScheme colors) => ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.transparent,
        elevation: 0.0,
        backgroundColor: colors.primaryContainer,
        foregroundColor: colors.primary,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        textStyle: textTheme.bodyMedium?.copyWith(color: colors.onPrimary),
      ),
    );
