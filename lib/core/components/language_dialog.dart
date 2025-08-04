import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../core/utils/app_context.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../localization/keys.g.dart';
import 'list_tile_item.dart';

class LanguageDialog extends StatelessWidget {
  const LanguageDialog({super.key});

  void _optionSelected(BuildContext context, int option) async =>
      await context.setLocale(context.supportedLocales[option]).then(
            (value) => context.pop(),
          );

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> data = [
      {
        "icon": TablerIcons.alphabet_arabic,
        "label": LocaleKeys.dialogs_language_arabic.tr(),
        "function": () => _optionSelected(context, 0),
      },
      {
        "icon": TablerIcons.language_hiragana,
        "label": LocaleKeys.dialogs_language_english.tr(),
        "function": () => _optionSelected(context, 1),
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
              LocaleKeys.dialogs_language_title.tr(),
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
