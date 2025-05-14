import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'text_font.dart';

InputDecorationTheme inputDecorationStyle(ColorScheme colors) =>
    InputDecorationTheme(
      // filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      // Enable Mode
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide(color: colors.outline, width: 1.0),
      ),
      prefixIconColor: colors.outline,
      suffixIconColor: colors.outline,
      labelStyle: textTheme.bodySmall?.copyWith(color: colors.outline),
      hintStyle: textTheme.bodyMedium?.copyWith(color: colors.outline),
      suffixIconConstraints: BoxConstraints.tight(Size(64, 40)),
      prefixIconConstraints: BoxConstraints.tight(Size(48, 24)),
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide(color: colors.primary, width: 1.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide(color: colors.error, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide(color: colors.error, width: 1.0),
      ),
      errorStyle: textTheme.labelSmall?.copyWith(color: colors.onError),
    );
