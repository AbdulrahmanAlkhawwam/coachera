import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/utils/app_context.dart';
import '../../../../core/utils/app_image.dart';
import '../../../home/domain/entities/card_type.dart';
import '../../domain/entities/instructor.dart';

class InstructorCard extends StatelessWidget {
  final Instructor? instructor;
  final bool loading;
  final CardType cardType;

  const InstructorCard({
    super.key,
    this.instructor,
    this.loading = false,
    this.cardType = CardType.vertical,
  });

  static const double _verticalWidth = 240;
  static const double _verticalHeight = 320;
  static const double _horizontalHeight = 120;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.surfaceContainer,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: loading || instructor == null
            ? null
            : () => context.push(
                  Routes.instructorDetails,
                  arguments: {'instructor': instructor},
                ),
        child: Container(
          width:
              cardType == CardType.vertical ? _verticalWidth : double.infinity,
          height: cardType == CardType.vertical
              ? _verticalHeight
              : _horizontalHeight,
          padding: const EdgeInsets.all(12),
          child: loading
              ? _buildLoadingState(context)
              : (cardType == CardType.vertical
                  ? _buildVertical(context)
                  : _buildHorizontal(context)),
        ),
      ),
    );
  }

  /// -------------------- Loading --------------------
  Widget _buildLoadingState(BuildContext context) {
    if (cardType == CardType.vertical) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Shimmer.fromColors(
            baseColor: context.colors.surfaceContainerHighest,
            highlightColor: context.colors.primaryContainer,
            child:
                const CircleAvatar(radius: 45, backgroundColor: Colors.white),
          ),
          const SizedBox(height: 16),
          _shimmerText(width: 140, height: 20, context: context),
          const SizedBox(height: 12),
          ...List.generate(
            3,
            (i) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: _shimmerText(
                width: i == 2 ? 80 : double.infinity,
                height: 20,
                context: context,
              ),
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Shimmer.fromColors(
            baseColor: context.colors.surfaceContainerHighest,
            highlightColor: context.colors.primaryContainer,
            child:
                const CircleAvatar(radius: 35, backgroundColor: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _shimmerText(width: 120, height: 20, context: context),
                const SizedBox(height: 8),
                _shimmerText(
                    width: double.infinity, height: 18, context: context),
                const SizedBox(height: 8),
                _shimmerText(width: 100, height: 18, context: context),
              ],
            ),
          )
        ],
      );
    }
  }

  /// -------------------- Vertical --------------------
  Widget _buildVertical(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 45,
            backgroundColor: context.colors.primaryContainer,
            child: ClipOval(
              child: AppImage(
                "https://avatar.iran.liara.run/public/${instructor!.id}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            instructor!.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.titleLarge,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              instructor!.bio,
              textAlign: TextAlign.center,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
          ),
        ],
      );

  /// -------------------- Horizontal --------------------
  Widget _buildHorizontal(BuildContext context) => Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: context.colors.primaryContainer,
            child: ClipOval(
              child: AppImage(
                "https://avatar.iran.liara.run/public/${instructor!.id}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  instructor!.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.titleMedium,
                ),
                Text(
                  instructor!.bio,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  /// -------------------- Shimmer Helper --------------------
  Widget _shimmerText({
    required double width,
    required double height,
    required BuildContext context,
  }) =>
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
