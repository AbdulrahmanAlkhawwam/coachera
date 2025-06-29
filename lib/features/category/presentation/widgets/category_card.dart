import 'package:coachera/core/utils/app_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import '../../domain/entities/category.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    this.color,
    required this.category,
  });

  final Color? color;
  final Category category;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _iconUI(context),
          const SizedBox(height: 8),
          Text(
            category.title,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colors.outline,
            ),
            textAlign: TextAlign.center,
          ),
        ],
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
}
