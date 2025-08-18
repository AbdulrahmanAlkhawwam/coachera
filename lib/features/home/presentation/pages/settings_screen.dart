import 'package:coachera/core/components/list_tile_item.dart';
import 'package:coachera/core/constants/routes.dart';
import 'package:coachera/core/localization/keys.g.dart';
import 'package:coachera/core/utils/app_context.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../../core/components/language_dialog.dart';
import '../../../../core/components/section_title.dart';
import '../../../../core/components/theme_dialog.dart';
import '../../../auth/presentation/manager/bloc/auth_bloc.dart';
import '../../../auth/presentation/widgets/logout_sheet.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> generalContent = [
      {
        'icon': null,
        'label': LocaleKeys.screens_setting_about.tr(),
      },
      if (context.read<AuthBloc>().state.userStatus != UserStatus.guest)
        {
          'icon': TablerIcons.key,
          'label': LocaleKeys.screens_setting_password.tr(),
          'route': Routes.forgotPassword,
        },
      {
        'icon': TablerIcons.question_mark,
        'label': LocaleKeys.screens_setting_faq.tr(),
        'route': Routes.faq,
      },
      {
        'icon': TablerIcons.shield_half_filled,
        'label': LocaleKeys.screens_setting_privacy.tr(),
        'route': Routes.privacy,
      },
      {
        'icon': null,
        'label': LocaleKeys.screens_setting_system.tr(),
      },
      {
        'icon': TablerIcons.language,
        'label': LocaleKeys.screens_setting_language.tr(),
        'route': null,
        'function': () async => await showDialog(
              context: context,
              builder: (context) => LanguageDialog(),
            ),
      },
      {
        'icon': context.isDark ? TablerIcons.sun : TablerIcons.moon,
        'label': LocaleKeys.screens_setting_mode.tr(),
        'route': null,
        'function': () async => await showDialog(
              context: context,
              builder: (context) => ThemeDialog(),
            ),
      },
      if (context.read<AuthBloc>().state.userStatus != UserStatus.guest)
        {
          'icon': TablerIcons.bell_ringing,
          'label': LocaleKeys.screens_setting_notification.tr(),
          'route': 'Routes.setting',
        },
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.canPop(context) ? context.pop() : null,
          icon: Icon(context.isLTR
              ? TablerIcons.chevron_left
              : TablerIcons.chevron_right),
        ),
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 16.0,
          bottom: 16.0 + context.bottomPadding,
        ),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
