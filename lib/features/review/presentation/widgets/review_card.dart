import 'package:coachera/core/utils/app_context.dart';
import 'package:coachera/core/utils/app_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../../core/components/rate.dart';
import '../../domain/entities/review.dart';

class ReviewCard extends StatelessWidget {
  final Review review;
  final String? reviewer;

  const ReviewCard({
    super.key,
    required this.review,
    this.reviewer,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colors.primaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
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
                    // if (review.courseId != null)
                    //   Text(
                    //     courseTitle!,
                    //     style: context.textTheme.titleSmall?.copyWith(
                    //         color: context.colors.onPrimaryContainer),
                    //   ),
                    Text(
                      reviewer ?? "Unknown User",
                      style: context.textTheme.labelLarge
                          ?.copyWith(color: context.colors.primary),
                    ),
                    Text(
                      DateFormat("d MMM yyyy").format(review.updatedAt),
                      style: context.textTheme.labelLarge
                          ?.copyWith(color: context.colors.outline),
                    ),
                    const SizedBox(height: 8),
                    Rate(
                      rate: review.rating.toDouble(),
                      startSize: 16.0,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              review.comment,
              style: context.textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
