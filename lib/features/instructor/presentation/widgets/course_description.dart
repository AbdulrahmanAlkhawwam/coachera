import 'package:coachera/core/utils/app_context.dart';
import 'package:flutter/material.dart';

class CourseDescription extends StatefulWidget {
  final String title;
  final String body;

  const CourseDescription({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  State<CourseDescription> createState() => _CourseDescriptionState();
}

class _CourseDescriptionState extends State<CourseDescription> {
  bool _isExpanded = false;
  bool _isLongText = false;
  final int _maxLines = 4;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final span = TextSpan(
          text: widget.body,
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        );

        final tp = TextPainter(
          text: span,
          maxLines: _maxLines,
          textDirection: TextDirection.ltr,
        );

        tp.layout(maxWidth: constraints.maxWidth);

        _isLongText = tp.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: context.textTheme.titleMedium,
            ),
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
                    color: context.colors.outlineVariant.withAlpha(160)),
              ),
              secondChild: Text(
                widget.body,
                style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colors.outlineVariant.withAlpha(160)),
              ),
            ),

            const SizedBox(height: 8),

            /// Show read more/less ONLY if needed
            if (_isLongText)
              GestureDetector(
                onTap: () => setState(() => _isExpanded = !_isExpanded),
                child: Text(
                  _isExpanded ? "Read less" : "Read more",
                  style: const TextStyle(
                    color: Color(0xFFFFBD12),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
