import 'package:flutter/material.dart';
import 'text_font.dart';

ExpansionTileThemeData expansionTileStyle(ColorScheme colors) =>
    ExpansionTileThemeData(
      backgroundColor: colors.primaryContainer,
      iconColor: colors.secondary,
      textColor: colors.onSurface,
      collapsedTextColor: colors.primary,
      collapsedIconColor: colors.primary.withAlpha(80),
      childrenPadding: EdgeInsets.all(8),
      collapsedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: colors.primary)),
      tilePadding: EdgeInsets.symmetric(horizontal: 16),
    );
