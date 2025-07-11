import 'package:coachera/core/utils/app_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/presentation/manager/cubit/theme_notifier.dart';

class ThemeDialog extends StatelessWidget {
  const ThemeDialog({super.key});

  void _optionSelected(BuildContext context, ThemeMode theme) {
    context.read<ThemeNotifier>().setThemeMode(theme);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.colors.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'LocaleKeys.dialog_theme_title.tr()',
              style: context.textTheme.titleSmall,
            ),
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(vertical: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: context.colors.surfaceContainer,
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  ListTile(
                    onTap: () => _optionSelected(context, ThemeMode.dark),
                    //context.pop("en"),
                    leading: Icon(
                      Icons.dark_mode_outlined,
                      color: context.colors.primaryContainer,
                    ),
                    title: Text(
                      'LocaleKeys.dialog_theme_dark.tr()',
                      style: context.textTheme.labelMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Divider(color: context.colors.outline),
                  ),
                  ListTile(
                    onTap: () => _optionSelected(context, ThemeMode.light),
                    //context.pop("ar"),
                    leading: Icon(
                      Icons.light_mode_outlined,
                      color: context.colors.primaryContainer,
                    ),
                    title: Text(
                      'LocaleKeys.dialog_theme_light.tr()',
                      style: context.textTheme.labelMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Divider(color: context.colors.outline),
                  ),
                  ListTile(
                    onTap: () => _optionSelected(context, ThemeMode.system),
                    //context.pop("ar"),
                    leading: Icon(
                      Icons.devices,
                      color: context.colors.primaryContainer,
                    ),
                    title: Text(
                      'LocaleKeys.dialog_theme_system.tr()',
                      style: context.textTheme.labelMedium,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
