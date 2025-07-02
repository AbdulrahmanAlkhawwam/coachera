import 'package:coachera/core/utils/app_context.dart';
import 'package:coachera/core/utils/message.dart';
import 'package:coachera/features/auth/presentation/manager/bloc/auth_bloc.dart';
import 'package:coachera/features/auth/presentation/pages/change_password_screen.dart';
import 'package:coachera/features/auth/presentation/pages/forget_password_screen.dart';
import 'package:coachera/features/auth/presentation/pages/login_screen.dart';
import 'package:coachera/features/auth/presentation/pages/register_screen.dart';
import 'package:coachera/features/auth/presentation/pages/reset_password_screen.dart';
import 'package:coachera/features/auth/presentation/pages/verification_screen.dart';
import 'package:coachera/features/auth/presentation/widgets/logout_sheet.dart';
import 'package:coachera/features/course/presentation/pages/courses_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TempScreen extends StatelessWidget {
  const TempScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screens = [
      {"name": "login", "function": LoginScreen()},
      {"name": "register", "function": RegisterScreen()},
      {"name": "verification", "function": VerificationScreen()},
      {"name": "send code email", "function": ForgetPasswordScreen()},
      {"name": "reset password", "function": ResetPasswordScreen()},
      {"name": "change password", "function": ChangePasswordScreen()},
      {"name": "courses", "function": CoursesScreen()},
    ];

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.error) {
            context.showErrorSnackBar(massage: state.message);
          }
          if (state.status == AuthStatus.unauthorized) {
            context.showSuccessSnackBar(
                massage: Message(
              value: "Logout Successfully 😊",
              title: "Success",
            ));
          }
        },
        child: SafeArea(
            child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                itemBuilder: (context, index) => FilledButton(
                  onPressed: () => context.push(screens[index]['function']),
                  child: Text("${screens[index]['name']}"),
                ),
                separatorBuilder: (context, index) => SizedBox(height: 16),
                itemCount: screens.length,
              ),
            ),
            FilledButton(
              onPressed: () async {
                final result = await showModalBottomSheet(
                      // isDismissible: false,

                      isScrollControlled: true,
                      useSafeArea: true,
                      builder: (context) => LogoutSheet(),
                      context: context,
                    ) ??
                    false;
                if (result) {
                  context.read<AuthBloc>().add(Logout());
                }
                print(result);
              },
              child: Text("logout"),
            ),
          ],
        )),
      ),
    );
  }
}
