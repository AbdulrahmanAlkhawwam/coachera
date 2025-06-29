import 'package:flutter/material.dart';

import 'text_font.dart';

TextButtonThemeData textButtonStyle(ColorScheme colors) => TextButtonThemeData(
      style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(colors.outline),
          overlayColor: WidgetStatePropertyAll(colors.outline.withAlpha(32)),
          textStyle: WidgetStatePropertyAll(textTheme.bodyMedium)),
    );
