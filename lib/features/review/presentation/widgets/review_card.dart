import 'package:coachera/core/utils/app_context.dart';
import 'package:coachera/core/utils/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../../core/components/rate.dart';

class ReviewCard extends StatelessWidget {
  final String? courseTitle;
  final String? reviewerName;
  final int rating;
  final String reviewText;
  final String date;

  const ReviewCard({
    super.key,
    this.courseTitle,
    required this.reviewerName,
    required this.rating,
    required this.reviewText,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colors.primaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AppImage(
                    "https://avatar.iran.liara.run/public",
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (courseTitle != null)
                      Text(
                        courseTitle!,
                        style: context.textTheme.titleSmall?.copyWith(
                            color: context.colors.onPrimaryContainer),
                      ),
                    Text(
                      reviewerName ?? "Unknown User",
                      style: context.textTheme.labelLarge
                          ?.copyWith(color: context.colors.primary),
                    ),
                    Text(
                      date,
                      style: context.textTheme.labelLarge
                          ?.copyWith(color: context.colors.outline),
                    ),
                    const SizedBox(height: 8),
                    Rate(
                      rate: rating.toDouble(),
                      startSize: 16.0,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              reviewText,
              style: context.textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
