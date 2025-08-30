import 'package:coachera/core/utils/app_context.dart';
import 'package:coachera/features/auth/presentation/manager/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/notification_card.dart';
import '../../../../core/constants/res.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/utils/app_image.dart';
import '../manager/notification_bloc/notification_bloc.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    context.read<NotificationBloc>().add(GetMyNotifications());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<NotificationBloc>().add(GetUnreadNotification());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Notification"),
        ),
        body: BlocListener<NotificationBloc, NotificationState>(
          listener: (context, state) {
            if (state.status == NotificationStatus.error) {
              context.showErrorSnackBar(massage: state.message);
            }
          },
          child: BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              return switch (state.status) {
                NotificationStatus.loading =>
                  const Center(child: CircularProgressIndicator()),
                _ => state.notification.isEmpty
                    ? _emptyList()
                    : ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: state.notification.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final notification = state.notification[index];
                          return NotificationCard(
                            notification: notification,
                            onMarkRead: () => context
                                .read<NotificationBloc>()
                                .add(MarkNotification(id: notification.id)),
                          );
                        },
                      )
              };
            },
          ),
        ),
      ),
    );
  }

  Widget _emptyList() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(),
            AppImage(
              context.isDark ? Res.notificationDark : Res.notificationLight,
              height: 160,
            ),
            const SizedBox(height: 16),
            Text(
              "There not notification Yet!",
              style: context.textTheme.headlineSmall
                  ?.copyWith(color: context.colors.onSurface),
            ),
            const SizedBox(height: 8),
            Text(
              textAlign: TextAlign.center,
              "You’re all caught up! New notifications will appear here.",
              style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colors.onPrimaryContainer.withAlpha(160)),
            ),
            Spacer(),
            if (context.read<AuthBloc>().state.userStatus ==
                UserStatus.guest) ...[
              OutlinedButton(
                onPressed: () => context.pushReplacement(Routes.login),
                child: Text('Login now !'),
              ),
              Spacer(),
            ]
          ],
        ),
      ),
    );
  }
}
