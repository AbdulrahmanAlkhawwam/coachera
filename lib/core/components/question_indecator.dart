import 'package:flutter/material.dart';

import '../../../../core/utils/app_context.dart';

class QuizIndicator extends StatelessWidget {
  final int currentIndex;
  final int total;

  const QuizIndicator({
    super.key,
    required this.currentIndex,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Row(
          children: List.generate(total, (index) {
            return Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                height: 6,
                decoration: BoxDecoration(
                  color: index < currentIndex
                      ? context.colors.primary
                      : index == currentIndex
                          ? context.colors.secondary
                          : context.colors.outline,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
