import 'package:coachera/features/home/domain/param/list_param.dart';
import 'package:coachera/features/home/domain/param/sort_param.dart';
import 'package:coachera/features/search/domain/entities/entity.dart';
import 'package:coachera/features/search/domain/params/search_param.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/utils/app_context.dart';
import '../../domain/entities/category.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    this.color,
    required this.category,
    this.loading = false,
  });

  final Color? color;
  final Category category;
  final bool loading;

  // final VoidCallback? onTap; // ✅ أضفنا function parameter

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: loading
          ? null
          : () => context.push(Routes.courseSearch, arguments: {
                'param': SearchParam(
                    param: ListParam(
                      page: 0,
                      sort: SortParam(),
                    ),
                    entity: Entity(id: '', name: ''),
                    input: category.id.toString())
              }),
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            loading ? _shimmerIcon(context) : _iconUI(context),
            const SizedBox(height: 8),
            loading
                ? _shimmerText(context)
                : Text(
                    category.title,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colors.outline,
                    ),
                    textAlign: TextAlign.center,
                  ),
          ],
        ),
      ),
    );
  }

  Widget _iconUI(BuildContext context) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: context.colors.primaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          TablerIcons.all[category.iconName],
          color: color ?? context.colors.primary,
          size: 32,
        ),
      );

  Widget _shimmerIcon(BuildContext context) => Shimmer.fromColors(
        baseColor: context.colors.surfaceContainer,
        highlightColor: context.colors.outline,
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );

  Widget _shimmerText(BuildContext context) => Shimmer.fromColors(
        baseColor: context.colors.surfaceContainer,
        highlightColor: context.colors.outline,
        child: Container(
          width: 60,
          height: 14,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      );
}

// import 'package:flutter/material.dart';
// import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
// import 'package:shimmer/shimmer.dart';
//
// import '../../../../core/utils/app_context.dart';
// import '../../domain/entities/category.dart';
//
// class CategoryCard extends StatelessWidget {
//
//   const CategoryCard({
//     super.key,
//     this.color,
//     required this.category,
//     this.loading = false,
//   });
//
//   final Color? color;
//   final Category category;
//   final bool loading;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           loading ? _shimmerIcon(context) : _iconUI(context),
//           const SizedBox(height: 8),
//           loading
//               ? _shimmerText(context)
//               : Text(
//                   category.title,
//                   style: context.textTheme.bodyMedium?.copyWith(
//                     color: context.colors.outline,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//         ],
//       ),
//     );
//   }
//
//   Widget _iconUI(BuildContext context) => Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: context.colors.primaryContainer,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Icon(
//           TablerIcons.all[category.iconName],
//           color: color ?? context.colors.primary,
//           size: 32,
//         ),
//       );
//
//   Widget _shimmerIcon(BuildContext context) => Shimmer.fromColors(
//         baseColor: context.colors.surfaceContainer,
//         highlightColor: context.colors.outline,
//         child: Container(
//           width: 56,
//           height: 56,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//           ),
//         ),
//       );
//
//   Widget _shimmerText(BuildContext context) => Shimmer.fromColors(
//         baseColor: context.colors.surfaceContainer,
//         highlightColor: context.colors.outline,
//         child: Container(
//           width: 60,
//           height: 14,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(4),
//           ),
//         ),
//       );
// }
