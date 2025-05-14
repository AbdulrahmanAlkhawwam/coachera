import 'package:coachera/core/theme/styles/FloatingButtonStyle.dart';
import 'package:coachera/core/theme/styles/appBar.dart';
import 'package:coachera/core/theme/styles/icon_button.dart';
import 'package:coachera/core/theme/styles/input_Decoration.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'styles/elevated_button.dart';
import 'styles/filled_button.dart';
import 'styles/tabBar.dart';
import 'styles/text_button.dart';
import 'styles/text_font.dart';

class Theme {
  static ThemeData get lightTheme => _theme(ColorSchemes.lightColors);

  static ThemeData get darkTheme => _theme(ColorSchemes.darkColor);

  static ThemeData _theme(ColorScheme colors) => ThemeData(
        colorScheme: colors,
        useMaterial3: true,
        textTheme: textTheme,
        tabBarTheme: tabBarStyle(colors),
        filledButtonTheme: filledButtonStyle(colors),
        textButtonTheme: textButtonStyle(colors),
        elevatedButtonTheme: elevatedButtonStyle(colors),
        scaffoldBackgroundColor: colors.surface,
        iconButtonTheme: iconButtonStyle(colors),
        appBarTheme: appBarStyle(colors),
        iconTheme: IconThemeData(color: colors.onSurface),
        inputDecorationTheme: inputDecorationStyle(colors),
        floatingActionButtonTheme: floatingButtonStyle(colors),
        // dividerColor: ColorPlatte.neutral100,
        // extensions:
      );
}
