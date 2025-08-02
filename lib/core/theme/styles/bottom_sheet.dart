import 'package:flutter/material.dart';

BottomSheetThemeData bottomSheetStyle(ColorScheme color) =>
    BottomSheetThemeData(
      showDragHandle: true,
      dragHandleSize: Size(40, 4),
      dragHandleColor: color.primary,
      modalBackgroundColor: color.surface,
      modalBarrierColor: Colors.black.withAlpha(125),
    );
