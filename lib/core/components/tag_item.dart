import 'package:flutter/material.dart';

import '../../../../core/utils/app_context.dart';

class TagItem extends StatefulWidget {
  const TagItem( {
    super.key,
    required this.isSelected,
    required this.onSelect,
    required this.text,
    this.avatar,
  });

  final String text;
  final Function(dynamic) onSelect;
  final bool isSelected;
  final Widget? avatar;

  @override
  State<TagItem> createState() => _TagItemState();
}

class _TagItemState extends State<TagItem> {
  @override
  Widget build(BuildContext context) => ChoiceChip(
        avatar: widget.avatar,
        label: Text(
          widget.text,
          style: context.textTheme.labelLarge?.copyWith(
            color: widget.isSelected
                ? context.colors.primary
                : context.colors.outline,
          ),
        ),
        selectedColor: context.colors.primaryContainer,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(
              color: widget.isSelected
                  ? context.colors.primary
                  : context.colors.outline),
        ),
        showCheckmark: false,
        selected: widget.isSelected,
        onSelected: widget.onSelect,
      );
}
