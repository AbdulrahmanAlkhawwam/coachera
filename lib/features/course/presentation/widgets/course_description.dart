import 'package:coachera/core/utils/app_context.dart';
import 'package:flutter/material.dart';

class CourseDescription extends StatefulWidget {
  final String? title;
  final String body;

  const CourseDescription({
    super.key,
    this.title,
    required this.body,
  });

  @override
  State<CourseDescription> createState() => _CourseDescriptionState();
}

class _CourseDescriptionState extends State<CourseDescription> {
  bool _isExpanded = false;
  final int _maxLines = 4;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Text(widget.title!, style: context.textTheme.titleSmall),
        AnimatedCrossFade(
          crossFadeState: _isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
          firstChild: Text(
            widget.body,
            maxLines: _maxLines,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colors.outlineVariant.withAlpha(160),
            ),
          ),
          secondChild: Text(
            widget.body,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colors.outlineVariant.withAlpha(160),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Text(_isExpanded ? "Read less" : "Read more",
              style: context.textTheme.labelLarge
                  ?.copyWith(color: context.colors.secondary)),
        ),
      ],
    );
  }
}
