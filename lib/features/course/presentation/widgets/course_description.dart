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
  final int _maxLines = 4; // collapsed line count

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        if (widget.title != null)
          Text(
            widget.title!,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

        const SizedBox(height: 8),

        /// Body with read more
        AnimatedCrossFade(
          crossFadeState: _isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
          firstChild: Text(
            widget.body,
            maxLines: _maxLines,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.grey),
          ),
          secondChild: Text(
            widget.body,
            style: const TextStyle(color: Colors.grey),
          ),
        ),

        const SizedBox(height: 8),

        /// Read more / less toggle
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
  }
}
