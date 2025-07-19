import 'package:coachera/core/utils/app_context.dart';
import 'package:flutter/material.dart';

class ListTileItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? route;
  final Color? backgroundColor;
  final Color? iconColor;
  final Function()? onTap;

  const ListTileItem({
    super.key,
    required this.icon,
    required this.label,
    this.route,
    this.backgroundColor,
    this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: backgroundColor ?? context.colors.primaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: iconColor ?? context.colors.primary),
      ),
      title: Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap ?? () => context.push(route!),
    );
  }
}
