import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import 'text_font.dart';

pinThemeStyle(ColorScheme colors) => PinThemeExtension(
      defaultPinTheme: PinTheme(
        margin: EdgeInsets.symmetric(horizontal: 4),
        width: double.infinity,
        height: 56,
        textStyle: textTheme.titleSmall,
        decoration: BoxDecoration(
          color: colors.primaryContainer,
          border: Border.all(color: colors.outline),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      focusedPinTheme: PinTheme(
        margin: EdgeInsets.symmetric(horizontal: 4),
        width: double.infinity,
        height: 56,
        textStyle: textTheme.titleSmall,
        decoration: BoxDecoration(
          color: colors.primaryContainer,
          border: Border.all(color: colors.primary),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      disabledPinTheme: PinTheme(
        margin: EdgeInsets.symmetric(horizontal: 4),
        width: double.infinity,
        height: 56,
        textStyle: textTheme.titleSmall,
        decoration: BoxDecoration(
          color: colors.primaryContainer,
          border: Border.all(color: colors.outline),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );

@immutable
class PinThemeExtension extends ThemeExtension<PinThemeExtension> {
  final PinTheme defaultPinTheme;
  final PinTheme focusedPinTheme;
  final PinTheme disabledPinTheme;

  const PinThemeExtension({
    required this.defaultPinTheme,
    required this.focusedPinTheme,
    required this.disabledPinTheme,
  });

  @override
  ThemeExtension<PinThemeExtension> copyWith({
    PinTheme? defaultPinTheme,
    PinTheme? focusedPinTheme,
    PinTheme? disabledPinTheme,
  }) {
    return PinThemeExtension(
      defaultPinTheme: defaultPinTheme ?? this.defaultPinTheme,
      focusedPinTheme: focusedPinTheme ?? this.focusedPinTheme,
      disabledPinTheme: disabledPinTheme ?? this.disabledPinTheme,
    );
  }

  @override
  ThemeExtension<PinThemeExtension> lerp(
    covariant ThemeExtension<PinThemeExtension>? other,
    double t,
  ) {
    if (other is! PinThemeExtension) return this;
    return this;
  }
}
