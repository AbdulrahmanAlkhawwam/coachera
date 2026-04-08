import 'package:flutter/material.dart';

import '../../../domain/use_cases/theme_uc.dart';

class ThemeNotifier with ChangeNotifier {
  final GetThemeUC getThemeUC;
  final SetThemeUC setThemeUC;

  ThemeNotifier({required this.setThemeUC, required this.getThemeUC}) {
    getThemeMode();
  }

  ThemeMode themeMode = ThemeMode.system;

  void getThemeMode() {
    final either = getThemeUC();
    either.fold(
      (failure) => print(failure.toString()),
      (themeMode) {
        this.themeMode = themeMode;
        notifyListeners();
      },
    );
  }

  void setThemeMode(ThemeMode themeMode) async {
    final either = await setThemeUC(themeMode);
    either.fold(
      (failure) => print(failure.toString()),
      (success) {
        this.themeMode = themeMode;
        notifyListeners();
      },
    );
  }

  String get themeLabel {
    switch (themeMode) {
      case ThemeMode.system:
        return 'LocaleKeys.settings_system_default_mode.tr()';
      case ThemeMode.light:
        return 'LocaleKeys.settings_light_mode.tr()';
      case ThemeMode.dark:
        return 'LocaleKeys.settings_dark_mode.tr()';
    }
  }
}
