import 'package:flutter/material.dart';

BottomNavigationBarThemeData bottomNavigationBarStyle(ColorScheme colors) =>
    BottomNavigationBarThemeData(
      selectedItemColor: colors.primary,
      unselectedItemColor: colors.outline,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
