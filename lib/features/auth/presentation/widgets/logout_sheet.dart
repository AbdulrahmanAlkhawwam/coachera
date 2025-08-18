import 'package:coachera/features/auth/presentation/manager/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/utils/app_context.dart';
import '../../../../core/utils/app_image.dart';
import '../../../../core/constants/res.dart';

class LogoutSheet extends StatelessWidget {
  const LogoutSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state.status == AuthStatus.unauthorized) {
          context.pushReplacement(Routes.login);
        }
        if (state.status == AuthStatus.error) {
          context.pop();
          context.showErrorSnackBar(massage: state.message);
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case AuthStatus.loading:
            return SizedBox(
              height: context.height / 2.6,
              child: Center(child: CircularProgressIndicator()),
            );
          default:
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
                    child: AppImage(
                      context.isDark ? Res.logoutDark : Res.logoutLight,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Sign out from Moment",
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Are you sure you would like to sign out of your Moment account?",
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => context.pop(),
                          child: const Text("Cancel"),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: FilledButton(
                          onPressed: () =>
                              context.read<AuthBloc>().add(Logout()),
                          child: const Text("Logout"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
        }
      },
    );
  }
}
