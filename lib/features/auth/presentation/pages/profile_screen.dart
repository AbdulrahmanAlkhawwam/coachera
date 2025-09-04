import 'package:coachera/core/components/list_tile_item.dart';
import 'package:coachera/core/constants/routes.dart';
import 'package:coachera/core/utils/app_context.dart';
import 'package:coachera/core/utils/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../manager/bloc/auth_bloc.dart';
import '../widgets/profile_item.dart';
import '../../../../core/components/section_title.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<AuthBloc>().add(GetMe());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          _ProfileHeader(),
          SizedBox(height: 16),
          Expanded(child: _ProfileList()),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthBloc>().state.user;
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF20C997),
            Color(0xFF18B4AC),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          AppBar(
            titleSpacing: 0.0,
            title: Text(
              "My Profile",
              style: context.textTheme.titleSmall?.copyWith(
                color: context.colors.surface,
                fontWeight: FontWeight.w700,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          const SizedBox(height: 16),
          CircleAvatar(
            radius: 45,
            backgroundColor: context.colors.surface,
            child: CircleAvatar(
              radius: 42,
              backgroundColor: Colors.transparent,
              child: ClipOval(
                child: AppImage(
                  "https://avatar.iran.liara.run/public/${user?.gender == 'male' ? 'boy' : 'girl'}?username=${user?.firstName}_${user?.lastName}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${user?.firstName} ${user?.lastName}',
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.colors.surface,
            ),
          ),
          Text(
            user?.education ?? "",
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w300,
              color: context.colors.surface,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _ProfileList extends StatelessWidget {
  const _ProfileList();

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> generalContent = [
      {'icon': null, 'label': "General"},
      {
        'icon': TablerIcons.user,
        'label': 'Personal Data',
        'route': 'Routes.settings',
      },
      {
        'icon': TablerIcons.credit_card,
        'label': 'Payments',
        'route': Routes.payment,
      },
      {
        'icon': TablerIcons.quote,
        'label': 'Reviews',
        'route': Routes.reviews,
      },
      {
        'icon': TablerIcons.certificate,
        'label': 'Certificate',
        'route': 'Routes.settings',
      },
      {
        'icon': null,
        'label': 'Other',
      },
      {
        'icon': TablerIcons.settings,
        'label': 'Settings',
        'route': Routes.setting,
      },
    ];
    return ListView.builder(
      itemBuilder: (context, index) => generalContent[index]['icon'] == null
          ? SectionTitle(title: generalContent[index]['label'])
          : ListTileItem(
              icon: generalContent[index]['icon'],
              label: generalContent[index]['label'],
              route: generalContent[index]['route'],
            ),
      itemCount: generalContent.length,
      padding: const EdgeInsets.symmetric(horizontal: 20),
    );
  }
}
