import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../features/home/presentation/manager/cubit/theme_notifier.dart';
import '../../../../core/utils/app_context.dart';
import '../localization/keys.g.dart';
import 'list_tile_item.dart';

class ThemeDialog extends StatelessWidget {
  const ThemeDialog({super.key});

  void _optionSelected(BuildContext context, ThemeMode theme) {
    context.read<ThemeNotifier>().setThemeMode(theme);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> data = [
      {
        "icon": TablerIcons.sun,
        "label": LocaleKeys.dialogs_theme_light.tr(),
        "function": () => _optionSelected(context, ThemeMode.light),
      },
      {
        "icon": TablerIcons.moon,
        "label": LocaleKeys.dialogs_theme_dark.tr(),
        "function": () => _optionSelected(context, ThemeMode.dark),
      },
      {
        "icon": TablerIcons.device_mobile,
        "label": LocaleKeys.dialogs_theme_system.tr(),
        "function": () => _optionSelected(context, ThemeMode.system),
      },
    ];

    return Dialog(
      backgroundColor: context.colors.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocaleKeys.dialogs_theme_title.tr(),
              style: context.textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Column(
                children: List.generate(
              data.length,
              (index) => ListTileItem(
                icon: data[index]["icon"],
                label: data[index]["label"],
                onTap: data[index]["function"],
                iconColor: context.colors.primary,
                trailingColor: Colors.transparent,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
