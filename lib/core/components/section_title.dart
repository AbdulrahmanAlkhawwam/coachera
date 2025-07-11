import 'package:coachera/core/utils/app_context.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: context.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
