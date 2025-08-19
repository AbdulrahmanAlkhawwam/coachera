
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../../core/utils/app_context.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/utils/app_image.dart';
import '../../domain/entities/course.dart';

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({super.key, required this.course});

  String colorToHex(Color color) {
    return color.value.toRadixString(16).padLeft(8, '0').toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(
        Routes.courseDetails,
        arguments: {'course': course},
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: context.colors.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: AppImage(
                course.image ??
                    "https://placehold.co/${context.widget}x160?text=${course.title.trim()}",
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: context.textTheme.titleMedium,
                  ),
                  Text(
                    course.description,
                    style: context.textTheme.bodySmall
                        ?.copyWith(color: context.colors.onSurfaceVariant),
                  ),
                  const SizedBox(height: 8),
                  Text('\$${course.price}',
                      style: context.textTheme.titleSmall
                          ?.copyWith(color: context.colors.primary)),
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: (course.rating * 2).round() / 2,
                        itemBuilder: (context, index) => Icon(
                          TablerIcons.star_filled,
                          color: context.colors.secondary,
                        ),
                        itemCount: 5,
                        itemSize: 16.0,
                        unratedColor: Colors.amber.withAlpha(120),
                        direction: Axis.horizontal,
                      ),
                      const SizedBox(width: 4),
                      Text('${course.rating}',
                          style: context.textTheme.bodySmall),
                      const Spacer(),
                      // todo : fix this
                      // IconButton(
                      //   style: ButtonStyle(
                      //     shape: WidgetStateProperty.all<OutlinedBorder>(
                      //       RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(16.0),
                      //       ),
                      //     ),
                      //   ),
                      // onPressed: () => context
                      //     .read<FavoriteBloc>()
                      //     .add(AddFavorite(courseId: course.id)),
                      // icon: Icon(
                      //   context
                      //               .read<FavoriteBloc>()
                      //               .state
                      //               .courses
                      //               ?.firstOrNull
                      //               ?.id ==
                      //           1
                      //       ? TablerIcons.heart_filled
                      //       : TablerIcons.heart,
                      //   size: 18,
                      //   color: context.colors.primary,
                      // ),
                      // ),
                    ],
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
