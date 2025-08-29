import 'package:coachera/core/utils/app_context.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../features/home/domain/entities/notification.dart';

class NotificationCard extends StatefulWidget {
  final Notification notification;
  final VoidCallback? onMarkRead;
  final VoidCallback? onTap;

  const NotificationCard({
    super.key,
    required this.notification,
    this.onMarkRead,
    this.onTap,
  });

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    bool isExpanded = false;

    return Dismissible(
      key: ValueKey(widget.notification.id),
      direction: widget.notification.read
          ? DismissDirection.none
          : DismissDirection.startToEnd,
      onDismissed: (_) => widget.onMarkRead?.call(),
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: context.colors.surfaceContainer,
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Icon(Icons.check_circle, color: context.colors.primary, size: 28),
            SizedBox(width: 8),
            Text(
              "Mark as read",
              style: TextStyle(
                  color: context.colors.onPrimaryContainer,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.notification.read
                ? context.colors.primaryContainer
                : context.colors.surface,
            width: 2,
          ),
          color: widget.notification.read
              ? context.colors.surface
              : context.colors.primaryContainer,
        ),
        child: InkWell(
          onLongPress: widget.onTap,
          onTap: () => setState(() => isExpanded = !isExpanded),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: widget.notification.read
                      ? context.colors.primaryContainer
                      : context.colors.onPrimary,
                  child: Icon(
                    _getTypeIcon(widget.notification.type),
                    color: context.colors.primary,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.notification.title,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: widget.notification.read
                              ? FontWeight.normal
                              : FontWeight.bold,
                          color: context.colors.primary,
                        ),
                      ),
                      Text(widget.notification.sentAt.toString(),
                          style: context.textTheme.bodySmall?.copyWith(
                              color: context.colors.onPrimaryContainer
                                  .withAlpha(120))),
                      const SizedBox(height: 4),
                      AnimatedCrossFade(
                        crossFadeState: isExpanded
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 300),
                        firstChild: Text(
                          widget.notification.content,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        secondChild: Text(
                          widget.notification.content,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "SYSTEM_ALERT":
        return TablerIcons.device_mobile;
      case "REMINDER":
        return Icons.alarm;
      case "MESSAGE":
        return Icons.mail;
      default:
        return Icons.notifications;
    }
  }
}
