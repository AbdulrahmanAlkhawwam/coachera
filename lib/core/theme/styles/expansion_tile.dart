import 'package:flutter/material.dart';
import 'text_font.dart';

ExpansionTileThemeData expansionTileStyle(ColorScheme colors) =>
    ExpansionTileThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      iconColor: colors.secondary,
      textColor: colors.onSurface,
      collapsedTextColor: colors.primary,
      collapsedIconColor: colors.primary.withAlpha(80),
      childrenPadding: EdgeInsets.symmetric(horizontal: 8),
      collapsedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tilePadding: EdgeInsets.symmetric(horizontal: 8),
    );
