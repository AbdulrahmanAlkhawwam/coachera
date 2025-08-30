import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/components/rate.dart';
import '../../../../core/utils/app_context.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/utils/app_image.dart';
import '../../domain/entities/course.dart';

class CourseVerticalCard extends StatelessWidget {
  final Course? course;
  final bool loading;

  const CourseVerticalCard({super.key, this.course, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading || course == null
          ? null
          : () => context.push(
                Routes.courseDetails,
                arguments: {'course': course},
              ),
      child: Container(
        width: 240,
        decoration: BoxDecoration(
          color: context.colors.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            loading ? _shimmerImage(context) : _courseImage(),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: loading
                    ? [
                        _shimmerText(width: 120, height: 16, context: context),
                        const SizedBox(height: 12),
                        _shimmerText(
                          width: double.infinity,
                          height: 12,
                          context: context,
                        ),
                        const SizedBox(height: 6),
                        _shimmerText(
                          width: double.infinity,
                          height: 12,
                          context: context,
                        ),
                        const SizedBox(height: 6),
                        _shimmerText(width: 120, height: 12, context: context),
                        const SizedBox(height: 18),
                        _shimmerText(width: 60, height: 24, context: context),
                        const SizedBox(height: 18),
                        Rate(loading: true),
                      ]
                    : [
                        Text(
                          course!.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.titleLarge,
                        ),
                        Text(
                          course!.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.labelLarge?.copyWith(
                            color: context.colors.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "\$${course!.price}",
                          style: context.textTheme.titleMedium?.copyWith(
                            color: context.colors.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Rate(
                              rate: (course!.rating * 2).round() / 2,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "${course!.rating}",
                              style: context.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _courseImage() => ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        child: AppImage(
          course!.image,
          height: 120,
          // width: double.infinity,
          fit: BoxFit.cover,
        ),
      );

  Widget _shimmerImage(BuildContext context) => Shimmer.fromColors(
        baseColor: context.colors.surfaceContainerHighest,
        highlightColor: context.colors.primaryContainer,
        child: Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.colors.primary,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
        ),
      );

  Widget _shimmerText(
          {required double width,
          required double height,
          required BuildContext context}) =>
      Shimmer.fromColors(
        baseColor: context.colors.surface,
        highlightColor: context.colors.primaryContainer,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      );
}
