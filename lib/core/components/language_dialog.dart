import '../../core/utils/app_context.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


class LanguageDialog extends StatelessWidget {
  const LanguageDialog({super.key});

  void _optionSelected(BuildContext context, int option) async =>
      await context.setLocale(context.supportedLocales[option]).then(
            (value) => context.pop(),
      );

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
              'LocaleKeys.dialog_lang_title.tr()',
              style: context.textTheme.titleSmall,
            ),
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(vertical: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: context.colors.surfaceContainer,
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  ListTile(
                    onTap: () => _optionSelected(context,1), //context.pop("en"),
                    titleAlignment: ListTileTitleAlignment.center,
                    title: Text(
                      'LocaleKeys.dialog_lang_en.tr()',
                      style: context.textTheme.labelMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Divider(color: context.colors.outline),
                  ),
                  ListTile(
                    onTap: () => _optionSelected(context,0), //context.pop("ar"),
                    titleAlignment: ListTileTitleAlignment.center,
                    title: Text(
                      'LocaleKeys.dialog_lang_ar.tr()',
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
