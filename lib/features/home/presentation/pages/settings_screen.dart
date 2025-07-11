import 'package:coachera/core/components/bounded_list.dart';
import 'package:coachera/core/components/list_tile_item.dart';
import 'package:coachera/core/localization/keys.g.dart';
import 'package:coachera/core/utils/app_context.dart';
import 'package:coachera/features/auth/presentation/widgets/profile_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../../core/components/language_dialog.dart';
import '../../../../core/components/section_title.dart';
import '../../../auth/presentation/manager/bloc/auth_bloc.dart';
import '../../../auth/presentation/widgets/logout_sheet.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // todo : fix the routes and add the logic for the button
    final List<Map<String, dynamic>> generalContent = [
      {
        'icon': null,
        'label': LocaleKeys.screens_setting_about.tr(),
      },
      {
        'icon': TablerIcons.key,
        'label': LocaleKeys.screens_setting_password.tr(),
        'route': 'Routes.settings',
      },
      {
        'icon': TablerIcons.question_mark,
        'label': LocaleKeys.screens_setting_faq.tr(),
        'route': 'Routes.settings',
      },
      {
        'icon': TablerIcons.shield_half_filled,
        'label': LocaleKeys.screens_setting_privacy.tr(),
        'route': 'Routes.settings',
      },
      {
        'icon': null,
        'label': LocaleKeys.screens_setting_system.tr(),
      },
      {
        'icon': TablerIcons.language,
        'label': LocaleKeys.screens_setting_language.tr(),
        'route': 'Routes.setting',
        'function': () async => await showDialog(
              context: context,
              builder: (context) => LanguageDialog(),
            ),
      },
      {
        'icon': TablerIcons.sun,
        'label': LocaleKeys.screens_setting_mode.tr(),
        'route': 'Routes.setting',
      },
      {
        'icon': TablerIcons.bell_ringing,
        'label': LocaleKeys.screens_setting_notification.tr(),
        'route': 'Routes.setting',
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) =>
                    generalContent[index]['icon'] == null
                        ? SectionTitle(title: generalContent[index]['label'])
                        : ListTileItem(
                            icon: generalContent[index]['icon'],
                            label: generalContent[index]['label'],
                            route: generalContent[index]['route'],
                            onTap: generalContent[index]['function'],
                          ),
                itemCount: generalContent.length,
              ),
            ),
            ListTileItem(
              icon: TablerIcons.logout,
              label: "Logout",
              iconColor: context.colors.error,
              backgroundColor: context.colors.errorContainer,
              onTap: () async => await showModalBottomSheet(
                isScrollControlled: true,
                useSafeArea: true,
                builder: (context) => LogoutSheet(),
                context: context,
              ).then(
                (result) {
                  result ?? false
                      ? context.read<AuthBloc>().add(Logout())
                      : null;
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
