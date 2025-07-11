import 'package:flutter/material.dart';

import 'colors.dart';
import 'styles/FloatingButtonStyle.dart';
import 'styles/appBar.dart';
import 'styles/bottom_navigation_bar_style.dart';
import 'styles/elevated_button.dart';
import 'styles/filled_button.dart';
import 'styles/icon_button.dart';
import 'styles/input_Decoration.dart';
import 'styles/list_tile_style.dart';
import 'styles/outline_button.dart';
import 'styles/tabBar.dart';
import 'styles/text_button.dart';
import 'styles/text_font.dart';
import 'styles/bottom_sheet_style.dart';

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
        outlinedButtonTheme: outlineButtonStyle(colors),
        bottomSheetTheme: bottomSheetStyle(colors),
        bottomNavigationBarTheme: bottomNavigationBarStyle(colors),
        listTileTheme:listTileStyle(colors),
        // dividerColor: ColorPlatte.neutral100,
        // extensions:
      );
}
