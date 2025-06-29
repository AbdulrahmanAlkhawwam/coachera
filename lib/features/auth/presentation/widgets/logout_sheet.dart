import 'package:flutter/material.dart';

import '../../../../core/utils/app_context.dart';
import '../../../../core/utils/app_image.dart';
import '../../../../core/constants/res.dart';

class LogoutSheet extends StatelessWidget {
  const LogoutSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom + 32,
        top: 32,
        left: 24,
        right: 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: AppImage(context.isDark ? Res.logoutDark : Res.logoutLight),
          ),
          const SizedBox(height: 24),
          Text(
            "Sign out from moment",
            style: context.textTheme.bodyLarge
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              textAlign: TextAlign.center,
              "Are you sure you would like to sign out of your moment account?",
              style: context.textTheme.bodyMedium
                  ?.copyWith(color: context.colors.onSurfaceVariant),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => context.pop(false),
                  child: Text("cancel"),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: FilledButton(
                  onPressed: () => context.pop(true),
                  child: Text("logout"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
