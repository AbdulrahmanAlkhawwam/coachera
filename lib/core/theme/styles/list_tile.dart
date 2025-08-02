import 'package:flutter/material.dart';
import 'text_font.dart';

ListTileThemeData listTileStyle(ColorScheme colors) => ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      iconColor: colors.outline,
      textColor: colors.onSurface,
      titleTextStyle:
          textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
    );
