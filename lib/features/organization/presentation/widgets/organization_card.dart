import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/res.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/utils/app_context.dart';
import '../../../../core/utils/app_image.dart';
import '../../domain/entities/organization.dart';

class OrganizationCard extends StatelessWidget {
  final Organization? organization;
  final bool loading;

  const OrganizationCard({super.key, this.organization, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading || organization == null
          ? null
          : () => context.push(
                Routes.organizationDetails,
                arguments: {'course': organization},
              ),
      child: Container(
        width: 240,
        decoration: BoxDecoration(
          color: context.colors.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: loading
                ? [
                    Shimmer.fromColors(
                        baseColor: context.colors.surfaceContainerHighest,
                        highlightColor: context.colors.primaryContainer,
                        child: AppImage(Res.spaceHolder, height: 48)),
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
                  ]
                : [
                    AppImage(Res.spaceHolder, height: 48),
                    const SizedBox(height: 16),
                    Text(
                      organization!.orgName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.titleLarge,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        textAlign: TextAlign.center,
                        organization!.orgDescription,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
          ),
        ),
      ),
    );
  }

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
