import 'package:coachera/core/components/tag_item.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/components/rate.dart';
import '../../../../core/utils/app_context.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/utils/app_image.dart';
import '../../../home/domain/entities/card_type.dart';
import '../../domain/entities/course.dart';

class CourseCard extends StatelessWidget {
  final Course? course;
  final bool loading;
  final CardType type;

  const CourseCard({
    super.key,
    this.course,
    this.loading = false,
    this.type = CardType.vertical,
  });

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
        width: type == CardType.vertical ? 240 : double.infinity,
        margin: type == CardType.horizontal
            ? const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
            : null,
        decoration: BoxDecoration(
          color: context.colors.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: type == CardType.vertical
            ? _buildVertical(context)
            : _buildHorizontal(context),
      ),
    );
  }

  /// ---------------- VERTICAL ----------------
  Widget _buildVertical(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        loading ? _shimmerImage(context, 120) : _courseImage(120),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: loading
                ? _shimmerVertical(context)
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
                        Rate(rate: (course!.rating * 2).round() / 2),
                        const SizedBox(width: 4),
                        Text("${course!.rating}",
                            style: context.textTheme.bodySmall),
                      ],
                    ),
                  ],
          ),
        ),
      ],
    );
  }

  /// ---------------- HORIZONTAL ----------------
  Widget _buildHorizontal(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        loading
            ? _shimmerImage(context, 160)
            : Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    child: AppImage(
                      course!.image ??
                          "https://placehold.co/240x160?text=${course!.title.trim()}",
                      height: 160, //todo: don't forget this
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TagItem(
                        isSelected: true,
                        onSelect: (value) {},
                        text: course?.categories.first.title ?? ''),
                  ),
                ],
              ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: loading
                ? _shimmerHorizontal(context)
                : [
                    Text(course!.title, style: context.textTheme.titleMedium),
                    Text(
                      course!.description,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$${course!.price}',
                      style: context.textTheme.titleSmall?.copyWith(
                        color: context.colors.primary,
                      ),
                    ),
                    Row(
                      children: [
                        Rate(
                          rate: (course!.rating * 2).round() / 2,
                          startSize: 16.0,
                        ),
                        const SizedBox(width: 4),
                        Text('${course!.rating}',
                            style: context.textTheme.bodySmall),
                        const Spacer(),
                        // TODO: favorite button
                      ],
                    )
                  ],
          ),
        ),
      ],
    );
  }

  /// ---------------- Helpers ----------------
  Widget _courseImage(double height) => ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        child: AppImage(
          course!.image ??
              "https://placehold.co/240x$height?text=${course!.title.trim()}",
          height: height, //todo: don't forget this
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );

  Widget _shimmerImage(BuildContext context, double height) =>
      Shimmer.fromColors(
        baseColor: context.colors.surfaceContainerHighest,
        highlightColor: context.colors.primaryContainer,
        child: Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.colors.primary,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
        ),
      );

  List<Widget> _shimmerVertical(BuildContext context) => [
        _shimmerText(context, 120, 16),
        const SizedBox(height: 12),
        _shimmerText(context, double.infinity, 12),
        const SizedBox(height: 6),
        _shimmerText(context, double.infinity, 12),
        const SizedBox(height: 6),
        _shimmerText(context, 120, 12),
        const SizedBox(height: 18),
        _shimmerText(context, 60, 24),
        const SizedBox(height: 18),
        Rate(loading: true),
      ];

  List<Widget> _shimmerHorizontal(BuildContext context) => [
        _shimmerText(context, 120, 16),
        const SizedBox(height: 8),
        _shimmerText(context, double.infinity, 12),
        const SizedBox(height: 8),
        _shimmerText(context, 80, 12),
        const SizedBox(height: 8),
        Rate(loading: true),
      ];

  Widget _shimmerText(BuildContext context, double width, double height) =>
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
