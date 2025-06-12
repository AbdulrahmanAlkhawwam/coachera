import 'package:coachera/core/utils/app_context.dart';
import 'package:coachera/features/auth/presentation/pages/forget_password_screen.dart';
import 'package:coachera/features/auth/presentation/pages/login_screen.dart';
import 'package:coachera/features/auth/presentation/pages/register_screen.dart';
import 'package:coachera/features/auth/presentation/pages/reset_password_screen.dart';
import 'package:coachera/features/auth/presentation/pages/verification_screen.dart';
import 'package:flutter/material.dart';

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
    ];

    return Scaffold(
      body: SafeArea(
          child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        itemBuilder: (context, index) => FilledButton(
          onPressed: () => context.push(screens[index]['function']),
          child: Text("${screens[index]['name']}"),
        ),
        separatorBuilder: (context, index) => SizedBox(height: 16),
        itemCount: screens.length,
      )),
    );
  }
}
