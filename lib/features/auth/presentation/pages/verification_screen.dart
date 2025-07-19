import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/components/screen.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/theme/styles/pin_theme.dart';
import '../../../../core/utils/app_context.dart';
import '../../domain/params/forget_password_param.dart';
import '../../domain/params/login_param.dart';
import '../manager/bloc/auth_bloc.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key, required this.email});

  final String email;

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  int _seconds = 300;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() => _timer = Timer.periodic(
        Duration(seconds: 1),
        (timer) => setState(() => _seconds > 0 ? _seconds-- : _timer?.cancel()),
      );

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pinTheme = Theme.of(context).extension<PinThemeExtension>()!;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.success && state.pin != null) {
          context.push(Routes.resetPassword, arguments: {
            'email': widget.email,
            'passkey': state.pin,
          });
        }
      },
      child: Screen(
        appBar: AppBar(title: Text("Verification OTP")),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "We sent a verification code to",
                style: context.textTheme.bodyMedium
                    ?.copyWith(color: context.colors.outline),
              ),
              Text(
                widget.email,
                style: context.textTheme.bodyLarge,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: Pinput(
                  autofocus: true,
                  enabled: _seconds > 0,
                  keyboardType: TextInputType.number,
                  defaultPinTheme: pinTheme.defaultPinTheme,
                  focusedPinTheme: pinTheme.focusedPinTheme,
                  disabledPinTheme: pinTheme.disabledPinTheme,
                  closeKeyboardWhenCompleted: true,
                  length: 6,
                  onCompleted: (pin) {
                    context.read<AuthBloc>().add(OTPValidation(
                        param: LoginParam(email: widget.email, password: pin)));
                  },
                ),
              ),
              const SizedBox(height: 32),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _formatTime(_seconds),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colors.primary,
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.read<AuthBloc>().add(
                          ForgetPassword(
                              param: ForgetPasswordParam(email: widget.email))),
                      child: Text(
                        "Resend Code?",
                        style: context.textTheme.bodyMedium
                            ?.copyWith(color: context.colors.onSurface),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
