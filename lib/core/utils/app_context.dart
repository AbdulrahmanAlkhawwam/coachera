import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../utils/message.dart';

extension AppNavigation on BuildContext {
  Future push(String route, {Map<String, dynamic>? arguments}) =>
      Navigator.pushNamed(
        this,
        route,
        arguments: arguments,
      );

  Future pushReplacement(String route, {Map<String, dynamic>? arguments}) =>
      Navigator.pushNamedAndRemoveUntil(
        this,
        route,
        (route) => false,
        arguments: arguments,
      );

  void pop([value]) => Navigator.pop(this, value);
}

extension AppTheme on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;

  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension AppResponsive on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;

  double get width => MediaQuery.sizeOf(this).width;

  double get bottomPadding => MediaQuery.paddingOf(this).bottom;

  double get bottomInsets => MediaQuery.viewInsetsOf(this).bottom;
}

extension AppDirectionality on BuildContext {
  TextDirection get textDirection => Directionality.of(this);

  bool get isRTL => textDirection == TextDirection.rtl;

  bool get isLTR => textDirection == TextDirection.ltr;
}

extension AppSnackbar on BuildContext {
  void showSuccessSnackBar({Message? massage}) {
    ScaffoldMessenger.of(this).clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: colors.primaryContainer,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.primary),
        ),
        duration: const Duration(milliseconds: 2500),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  TablerIcons.rosette_discount_check,
                  color: colors.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  textAlign: TextAlign.start,
                  "${massage?.title.toString()}",
                  style: textTheme.titleMedium?.copyWith(
                    color: colors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              textAlign: TextAlign.start,
              "${massage?.value.toString()}",
              style: textTheme.bodyMedium?.copyWith(
                color: colors.onPrimaryContainer,
              ),
            )
          ],
        ),
      ),
    );
  }

  void showErrorSnackBar({Message? massage}) {
    ScaffoldMessenger.of(this).clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: colors.errorContainer,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.error),
        ),
        duration: const Duration(milliseconds: 2500),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  TablerIcons.exclamation_circle,
                  color: colors.error,
                ),
                const SizedBox(width: 12),
                Text(
                  textAlign: TextAlign.start,
                  "${massage?.title.toString()}",
                  style: textTheme.titleMedium?.copyWith(
                    color: colors.error,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              textAlign: TextAlign.start,
              "${massage?.value.toString()}",
              style: textTheme.bodyMedium?.copyWith(
                color: colors.onErrorContainer,
              ),
            )
          ],
        ),
      ),
    );
  }
}
