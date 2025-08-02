import 'package:flutter/material.dart';

import 'text_font.dart';

TabBarThemeData tabBarStyle(ColorScheme colors) => TabBarThemeData(
      unselectedLabelStyle: textTheme.bodyMedium,
      labelStyle: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
      dividerColor: Colors.transparent,
      unselectedLabelColor: colors.outline,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: colors.primary,
    );
