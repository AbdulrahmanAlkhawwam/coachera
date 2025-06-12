import 'dart:async';

import 'package:coachera/core/components/screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/utils/app_context.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

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
    return Screen(
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
              "maulana****gmail.com",
              style: context.textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: Pinput(
                  autofocus: true,
                  enabled: _seconds > 0,
                  keyboardType: TextInputType.number,
                  closeKeyboardWhenCompleted: true,
                  defaultPinTheme: PinTheme(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: double.infinity,
                    height: 56,
                    textStyle: context.textTheme.titleSmall,
                    decoration: BoxDecoration(
                      color: context.colors.primaryContainer,
                      border: Border.all(color: context.colors.outline),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  focusedPinTheme: PinTheme(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: double.infinity,
                    height: 56,
                    textStyle: context.textTheme.titleSmall,
                    decoration: BoxDecoration(
                      color: context.colors.primaryContainer,
                      border: Border.all(color: context.colors.primary),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  disabledPinTheme: PinTheme(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: double.infinity,
                    height: 56,
                    textStyle: context.textTheme.titleSmall,
                    decoration: BoxDecoration(
                      color: context.colors.primaryContainer,
                      border: Border.all(color: context.colors.outline),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  length: 6,
                  onCompleted: (pin) => print(pin)
                  // context.read<AuthBloc>().add(OTP(passkey: pin)),
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
                    onPressed: () {},
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
    );
  }
}
