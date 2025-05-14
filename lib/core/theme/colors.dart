import 'package:flutter/material.dart';

class ColorSchemes {
  static Color white = const Color(0xFFFFFFFF);
  static Color gray = const Color(0xFF697B7A);
  static Color turquoiseGreen = const Color(0xFF2EC4B6);
  static Color darkGreen = const Color(0xFF092724);
  static Color vividOrange = const Color(0xFFFF9F1C);
  static Color poppy = const Color(0xFFD64545);
  static Color babyPowder = const Color(0xFFF6FBFA);


  static ColorScheme lightColors = ColorScheme(
    brightness: Brightness.light,

    // primary
    primary: ColorSchemes.turquoiseGreen,
    onPrimary: ColorSchemes.white,
    primaryContainer: ColorSchemes.babyPowder,
    onPrimaryContainer: ColorSchemes.darkGreen,

    // secondary
    secondary: ColorSchemes.vividOrange,
    onSecondary: ColorSchemes.white,
    secondaryContainer: const Color(0xFFFFECD2),
    onSecondaryContainer: const Color(0xFF332006),

    // error
    // error: const Color(0xFFAB3737),
    error: ColorSchemes.poppy,
    onError: ColorSchemes.white,
    errorContainer: const Color(0xFFFDF6F6),
    onErrorContainer: const Color(0xFF2B0E0E),

    // surface
    surface: ColorSchemes.white,
    onSurface: ColorSchemes.darkGreen,
    surfaceContainerHighest: const Color(0xFFD5F3F0),
    surfaceContainer: ColorSchemes.babyPowder,
    onSurfaceVariant: ColorSchemes.gray,

    // outline
    outline: const Color(0xFFC9CCCC),
  );

  static ColorScheme darkColor = ColorScheme(
    brightness: Brightness.dark,

    // primary
    primary: ColorSchemes.turquoiseGreen,
    onPrimary: const Color(0xFF124E49),
    primaryContainer: const Color(0xFF1C382D),
    onPrimaryContainer: const Color(0xFFD5F3F0),

    // secondary
    secondary: ColorSchemes.vividOrange,
    onSecondary: const Color(0xFF66400B),
    secondaryContainer: const Color(0xFF995F11),
    onSecondaryContainer: const Color(0xFFFFECD2),

    // surface
    surface: ColorSchemes.darkGreen,
    onSurface: const Color(0xFFF5F6F6),
    surfaceContainerHighest: const Color(0xFF3A5250),
    surfaceContainer: const Color(0xFF071F1D),
    onSurfaceVariant: ColorSchemes.gray,

    // error
    error: ColorSchemes.poppy,
    onError: const Color(0xFF561C1C),
    errorContainer: const Color(0xFF382726),
    onErrorContainer: const Color(0xFFF7DADA),

    // outline
    outline: const Color(0xFF3A5250),
  );
}

