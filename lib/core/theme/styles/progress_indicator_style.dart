import 'package:flutter/material.dart';

ProgressIndicatorThemeData progressIndicatorStyle(ColorScheme colors) =>
    ProgressIndicatorThemeData(
      color: colors.outline,
      constraints: BoxConstraints.tight(Size(24, 24)),
    );
