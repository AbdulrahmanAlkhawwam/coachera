import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/utils/app_context.dart';
import '../../../home/domain/entities/card_type.dart';
import '../../domain/entities/organization.dart';

class OrganizationCard extends StatelessWidget {
  final Organization? organization;
  final bool loading;
  final CardType cardType;

  static const double _verticalHeight = 240; // fixed vertical height

  const OrganizationCard({
    super.key,
    this.organization,
    this.loading = false,
    this.cardType = CardType.vertical,
  });

  @override
  Widget build(BuildContext context) {
    final child = loading ? _buildLoading(context) : _buildContent(context);

    return GestureDetector(
      onTap: loading || organization == null
          ? null
          : () => context.push(
                Routes.organizationDetails,
                arguments: {'organization': organization},
              ),
      child: Container(
        width: cardType == CardType.vertical ? 240 : double.infinity,
        height: cardType == CardType.vertical ? _verticalHeight : null,
        decoration: BoxDecoration(
          color: context.colors.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(10),
        child: cardType == CardType.vertical
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: child,
                ),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      TablerIcons.building_community,
                      color: context.colors.primary,
                      size: 40,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: child,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  List<Widget> _buildLoading(BuildContext context) => [
        Shimmer.fromColors(
          baseColor: context.colors.surfaceContainerHighest,
          highlightColor: context.colors.primaryContainer,
          child: Icon(
            TablerIcons.building_community,
            color: context.colors.primary,
            size: 40,
          ),
        ),
        const SizedBox(height: 16),
        _shimmerText(width: 140, context: context, height: 20),
        const SizedBox(height: 12),
        ...List.generate(
          4,
          (i) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: _shimmerText(
              width: i == 3 ? 80 : double.infinity,
              context: context,
              height: 20,
            ),
          ),
        ),
      ];

  List<Widget> _buildContent(BuildContext context) => [
        if (cardType == CardType.vertical) ...[
          Icon(
            TablerIcons.building_community,
            color: context.colors.primary,
            size: 40,
          ),
          const SizedBox(height: 16),
        ],
        Text(
          organization!.orgName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.titleLarge,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            textAlign: cardType == CardType.vertical
                ? TextAlign.center
                : TextAlign.start,
            organization!.orgDescription,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),
        ),
      ];

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
// import '../../domain/entities/organization.dart';
//
// class OrganizationCard extends StatelessWidget {
//   final Organization? organization;
//   final bool loading;
//   final CardType cardType;
//
//   const OrganizationCard({
//     super.key,
//     this.organization,
//     this.loading = false,
//     this.cardType = CardType.vertical,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: loading || organization == null
//           ? null
//           : () => context.push(
//                 Routes.organizationDetails,
//                 arguments: {'organization': organization},
//               ),
//       child: Container(
//         width: cardType == CardType.vertical ? 240 : double.infinity,
//         decoration: BoxDecoration(
//           color: context.colors.surfaceContainer,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         padding: const EdgeInsets.all(10),
//         child: cardType == CardType.vertical
//             ? _buildVerticalLayout(context)
//             : _buildHorizontalLayout(context),
//       ),
//     );
//   }
//
//   /// Vertical Layout
//   Widget _buildVerticalLayout(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: loading
//             ? [
//                 Shimmer.fromColors(
//                   baseColor: context.colors.surfaceContainerHighest,
//                   highlightColor: context.colors.primaryContainer,
//                   child: Icon(
//                     TablerIcons.building_community,
//                     color: context.colors.primary,
//                     size: 40,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 _shimmerText(width: 140, context: context, height: 20),
//                 const SizedBox(height: 12),
//                 ...List.generate(
//                   4,
//                   (i) => Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 4),
//                     child: _shimmerText(
//                       width: i == 3 ? 80 : double.infinity,
//                       context: context,
//                       height: 20,
//                     ),
//                   ),
//                 ),
//               ]
//             : [
//                 Icon(
//                   TablerIcons.building_community,
//                   color: context.colors.primary,
//                   size: 40,
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   organization!.orgName,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: context.textTheme.titleLarge,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     textAlign: TextAlign.center,
//                     organization!.orgDescription,
//                     maxLines: 5,
//                     overflow: TextOverflow.ellipsis,
//                     style: context.textTheme.bodyMedium?.copyWith(
//                       color: context.colors.onSurfaceVariant,
//                     ),
//                   ),
//                 ),
//               ],
//       ),
//     );
//   }
//
//   /// Horizontal Layout
//   Widget _buildHorizontalLayout(BuildContext context) {
//     return Row(
//       children: [
//         loading
//             ? Shimmer.fromColors(
//                 baseColor: context.colors.surfaceContainerHighest,
//                 highlightColor: context.colors.primaryContainer,
//                 child: Icon(
//                   TablerIcons.building_community,
//                   color: context.colors.primary,
//                   size: 40,
//                 ),
//               )
//             : Icon(
//                 TablerIcons.building_community,
//                 color: context.colors.primary,
//                 size: 40,
//               ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: loading
//                 ? [
//                     _shimmerText(width: 120, context: context, height: 18),
//                     const SizedBox(height: 8),
//                     ...List.generate(
//                       3,
//                       (i) => Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 2),
//                         child: _shimmerText(
//                           width: i == 2 ? 80 : double.infinity,
//                           context: context,
//                           height: 16,
//                         ),
//                       ),
//                     ),
//                   ]
//                 : [
//                     Text(
//                       organization!.orgName,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: context.textTheme.titleLarge,
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       organization!.orgDescription,
//                       maxLines: 3,
//                       overflow: TextOverflow.ellipsis,
//                       style: context.textTheme.bodyMedium?.copyWith(
//                         color: context.colors.onSurfaceVariant,
//                       ),
//                     ),
//                   ],
//           ),
//         ),
//       ],
//     );
//   }
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
//
// // import 'package:flutter/material.dart';
// // import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
// // import 'package:shimmer/shimmer.dart';
// //
// // import '../../../../core/constants/routes.dart';
// // import '../../../../core/utils/app_context.dart';
// // import '../../domain/entities/organization.dart';
// //
// // class OrganizationCard extends StatelessWidget {
// //   final Organization? organization;
// //   final bool loading;
// //
// //   const OrganizationCard({super.key, this.organization, this.loading = false});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: loading || organization == null
// //           ? null
// //           : () => context.push(
// //                 Routes.organizationDetails,
// //                 arguments: {'organization': organization},
// //               ),
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
// //                     Shimmer.fromColors(
// //                       baseColor: context.colors.surfaceContainerHighest,
// //                       highlightColor: context.colors.primaryContainer,
// //                       child: Icon(
// //                         TablerIcons.building_community,
// //                         color: context.colors.primary,
// //                         size: 40,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 16),
// //                     _shimmerText(width: 140, context: context, height: 20),
// //                     const SizedBox(height: 12),
// //                     ...List.generate(
// //                       4,
// //                       (i) => Padding(
// //                         padding: const EdgeInsets.symmetric(vertical: 4),
// //                         child: _shimmerText(
// //                           width: i == 3 ? 80 : double.infinity,
// //                           context: context,
// //                           height: 20,
// //                         ),
// //                       ),
// //                     ),
// //                   ]
// //                 : [
// //                     Icon(
// //                       TablerIcons.building_community,
// //                       color: context.colors.primary,
// //                       size: 40,
// //                     ),
// //                     const SizedBox(height: 16),
// //                     Text(
// //                       organization!.orgName,
// //                       maxLines: 1,
// //                       overflow: TextOverflow.ellipsis,
// //                       style: context.textTheme.titleLarge,
// //                     ),
// //                     Padding(
// //                       padding: const EdgeInsets.all(8.0),
// //                       child: Text(
// //                         textAlign: TextAlign.center,
// //                         organization!.orgDescription,
// //                         maxLines: 5,
// //                         overflow: TextOverflow.ellipsis,
// //                         style: context.textTheme.bodyMedium?.copyWith(
// //                           color: context.colors.onSurfaceVariant,
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _shimmerText(
// //           {required double width,
// //           required double height,
// //           required BuildContext context}) =>
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
