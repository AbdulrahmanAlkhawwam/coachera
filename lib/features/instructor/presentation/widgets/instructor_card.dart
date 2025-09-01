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

// import 'package:flutter/material.dart';
// import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
// import 'package:shimmer/shimmer.dart';
//
// import '../../../../core/constants/routes.dart';
// import '../../../../core/utils/app_context.dart';
// import '../../../home/domain/entities/card_type.dart';
// import '../../domain/entities/instructor.dart';
//
// class InstructorCard extends StatelessWidget {
//   final Instructor? instructor;
//   final bool loading;
//   final CardType cardType;
//
//   static const double _verticalHeight = 280; // fixed height for vertical card
//
//   const InstructorCard({
//     super.key,
//     this.instructor,
//     this.loading = false,
//     this.cardType = CardType.vertical,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final child = loading ? _buildLoading(context) : _buildContent(context);
//
//     return GestureDetector(
//       onTap: loading || instructor == null
//           ? null
//           : () => context.push(
//                 Routes.instructorDetails,
//                 arguments: {'instructor': instructor},
//               ),
//       child: Container(
//         width: cardType == CardType.vertical ? 240 : double.infinity,
//         height: cardType == CardType.vertical ? _verticalHeight : null,
//         decoration: BoxDecoration(
//           color: context.colors.surfaceContainer,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         padding: const EdgeInsets.all(10),
//         child: cardType == CardType.vertical
//             ? Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: child,
//               )
//             : Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(12),
//                     child: Icon(
//                       TablerIcons.user_circle,
//                       color: context.colors.primary,
//                       size: 40,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: child,
//                     ),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
//
//   List<Widget> _buildLoading(BuildContext context) => [
//         Shimmer.fromColors(
//           baseColor: context.colors.surfaceContainerHighest,
//           highlightColor: context.colors.primaryContainer,
//           child: Icon(
//             TablerIcons.user_circle,
//             color: context.colors.primary,
//             size: 40,
//           ),
//         ),
//         const SizedBox(height: 16),
//         _shimmerText(width: 120, height: 20, context: context),
//         const SizedBox(height: 12),
//         _shimmerText(width: 160, height: 18, context: context),
//         const SizedBox(height: 12),
//         ...List.generate(
//           3,
//           (i) => Padding(
//             padding: const EdgeInsets.symmetric(vertical: 4),
//             child: _shimmerText(
//               width: i == 2 ? 80 : double.infinity,
//               height: 16,
//               context: context,
//             ),
//           ),
//         ),
//       ];
//
//   List<Widget> _buildContent(BuildContext context) => [
//         if (cardType == CardType.vertical) ...[
//           Icon(
//             TablerIcons.user_circle,
//             color: context.colors.primary,
//             size: 40,
//           ),
//           const SizedBox(height: 16),
//         ],
//         Text(
//           instructor!.name,
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//           style: context.textTheme.titleLarge,
//         ),
//         const SizedBox(height: 8),
//         Text(
//           instructor!.name,
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//           style: context.textTheme.bodyMedium?.copyWith(
//             color: context.colors.onSurfaceVariant,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           instructor!.bio,
//           maxLines: 4,
//           overflow: TextOverflow.ellipsis,
//           style: context.textTheme.bodySmall?.copyWith(
//             color: context.colors.onSurfaceVariant,
//           ),
//         ),
//       ];
//
//   Widget _shimmerText({
//     required double width,
//     required double height,
//     required BuildContext context,
//   }) =>
//       Shimmer.fromColors(
//         baseColor: context.colors.surface,
//         highlightColor: context.colors.primaryContainer,
//         child: Container(
//           width: width,
//           height: height,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(4),
//           ),
//         ),
//       );
// }

// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';
//
// import '../../../../core/constants/routes.dart';
// import '../../../../core/utils/app_context.dart';
// import '../../../../core/utils/app_image.dart';
// import '../../../home/domain/entities/card_type.dart';
// import '../../domain/entities/instructor.dart';
//
// class InstructorCard extends StatelessWidget {
//   final Instructor? instructor;
//   final bool loading;
//   final CardType cardType;
//
//   const InstructorCard({
//     super.key,
//     this.instructor,
//     this.loading = false,
//     this.cardType = CardType.vertical,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: context.colors.surfaceContainer,
//       borderRadius: BorderRadius.circular(16),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(16),
//         onTap: loading || instructor == null
//             ? null
//             : () => context.push(
//                   Routes.instructorDetails,
//                   arguments: {'instructor': instructor},
//                 ),
//         child: Container(
//           width: cardType == CardType.vertical ? 240 : double.infinity,
//           padding: const EdgeInsets.all(12),
//           child: loading
//               ? _buildLoadingState(context)
//               : (cardType == CardType.vertical
//                   ? _buildVertical(context)
//                   : _buildHorizontal(context)),
//         ),
//       ),
//     );
//   }
//
//   /// -------------------- Loading --------------------
//   Widget _buildLoadingState(BuildContext context) {
//     if (cardType == CardType.vertical) {
//       return Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Shimmer.fromColors(
//             baseColor: context.colors.surfaceContainerHighest,
//             highlightColor: context.colors.primaryContainer,
//             child:
//                 const CircleAvatar(radius: 45, backgroundColor: Colors.white),
//           ),
//           const SizedBox(height: 16),
//           _shimmerText(width: 140, height: 20, context: context),
//           const SizedBox(height: 12),
//           ...List.generate(
//             3,
//             (i) => Padding(
//               padding: const EdgeInsets.symmetric(vertical: 4),
//               child: _shimmerText(
//                 width: i == 2 ? 80 : double.infinity,
//                 height: 20,
//                 context: context,
//               ),
//             ),
//           ),
//         ],
//       );
//     } else {
//       return Row(
//         children: [
//           Shimmer.fromColors(
//             baseColor: context.colors.surfaceContainerHighest,
//             highlightColor: context.colors.primaryContainer,
//             child:
//                 const CircleAvatar(radius: 35, backgroundColor: Colors.white),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _shimmerText(width: 120, height: 20, context: context),
//                 const SizedBox(height: 8),
//                 _shimmerText(
//                     width: double.infinity, height: 18, context: context),
//                 const SizedBox(height: 8),
//                 _shimmerText(width: 100, height: 18, context: context),
//               ],
//             ),
//           )
//         ],
//       );
//     }
//   }
//
//   /// -------------------- Vertical --------------------
//   Widget _buildVertical(BuildContext context) => Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           CircleAvatar(
//             radius: 45,
//             backgroundColor: context.colors.primaryContainer,
//             child: ClipOval(
//               child: AppImage(
//                 "https://avatar.iran.liara.run/public/${instructor!.id}",
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),
//           Text(
//             instructor!.name,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: context.textTheme.titleLarge,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               instructor!.bio,
//               textAlign: TextAlign.center,
//               maxLines: 5,
//               overflow: TextOverflow.ellipsis,
//               style: context.textTheme.bodyMedium?.copyWith(
//                 color: context.colors.onSurfaceVariant,
//               ),
//             ),
//           ),
//         ],
//       );
//
//   /// -------------------- Horizontal --------------------
//   Widget _buildHorizontal(BuildContext context) => Row(
//         children: [
//           CircleAvatar(
//             radius: 35,
//             backgroundColor: context.colors.primaryContainer,
//             child: ClipOval(
//               child: AppImage(
//                 "https://avatar.iran.liara.run/public/${instructor!.id}",
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   instructor!.name,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: context.textTheme.titleMedium,
//                 ),
//                 Text(
//                   instructor!.bio,
//                   maxLines: 3,
//                   overflow: TextOverflow.ellipsis,
//                   style: context.textTheme.bodyMedium?.copyWith(
//                     color: context.colors.onSurfaceVariant,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       );
//
//   /// -------------------- Shimmer Helper --------------------
//   Widget _shimmerText({
//     required double width,
//     required double height,
//     required BuildContext context,
//   }) =>
//       Shimmer.fromColors(
//         baseColor: context.colors.surface,
//         highlightColor: context.colors.primaryContainer,
//         child: Container(
//           width: width,
//           height: height,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(4),
//           ),
//         ),
//       );
// }
//
// // import 'package:flutter/material.dart';
// // import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
// // import 'package:shimmer/shimmer.dart';
// //
// // import '../../../../core/constants/res.dart';
// // import '../../../../core/constants/routes.dart';
// // import '../../../../core/utils/app_context.dart';
// // import '../../../../core/utils/app_image.dart';
// // import '../../domain/entities/instructor.dart';
// //
// // class InstructorCard extends StatelessWidget {
// //   final Instructor? instructor;
// //   final bool loading;
// //
// //   const InstructorCard({super.key, this.instructor, this.loading = false});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: loading || instructor == null
// //           ? null
// //           : () =>
// //           context.push(
// //             Routes.instructorDetails,
// //             arguments: {'instructor': instructor},
// //           ),
// //       child: Container(
// //         width: 240,
// //         decoration: BoxDecoration(
// //           color: context.colors.surfaceContainer,
// //           borderRadius: BorderRadius.circular(16),
// //         ),
// //         padding: const EdgeInsets.all(10),
// //         child: Center(
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             crossAxisAlignment: CrossAxisAlignment.center,
// //             children: loading
// //                 ? [
// //               Shimmer.fromColors(
// //                 baseColor: context.colors.surfaceContainerHighest,
// //                 highlightColor: context.colors.primaryContainer,
// //                 child: CircleAvatar(
// //                   radius: 45,
// //                   backgroundColor: context.colors.surface,
// //                 ),
// //               ),
// //               const SizedBox(height: 16),
// //               _shimmerText(width: 140, context: context, height: 20),
// //               const SizedBox(height: 12),
// //               ...List.generate(
// //                 4,
// //                     (i) =>
// //                     Padding(
// //                       padding: const EdgeInsets.symmetric(vertical: 4),
// //                       child: _shimmerText(
// //                         width: i == 3 ? 80 : double.infinity,
// //                         context: context,
// //                         height: 20,
// //                       ),
// //                     ),
// //               ),
// //             ]
// //                 : [
// //               CircleAvatar(
// //                 radius: 45,
// //                 backgroundColor: context.colors.primaryContainer,
// //                 child: CircleAvatar(
// //                   radius: 42,
// //                   backgroundColor: Colors.transparent,
// //                   child: ClipOval(
// //                     child: AppImage(
// //                       "https://avatar.iran.liara.run/public/${instructor!.id}",
// //                       fit: BoxFit.cover,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 16),
// //               Text(
// //                 instructor!.name,
// //                 maxLines: 1,
// //                 overflow: TextOverflow.ellipsis,
// //                 style: context.textTheme.titleLarge,
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: Text(
// //                   textAlign: TextAlign.center,
// //                   instructor!.bio,
// //                   maxLines: 5,
// //                   overflow: TextOverflow.ellipsis,
// //                   style: context.textTheme.bodyMedium?.copyWith(
// //                     color: context.colors.onSurfaceVariant,
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _shimmerText({required double width,
// //     required double height,
// //     required BuildContext context}) =>
// //       Shimmer.fromColors(
// //         baseColor: context.colors.surface,
// //         highlightColor: context.colors.primaryContainer,
// //         child: Container(
// //           width: width,
// //           height: height,
// //           decoration: BoxDecoration(
// //             color: Colors.white,
// //             borderRadius: BorderRadius.circular(4),
// //           ),
// //         ),
// //       );
// // }
