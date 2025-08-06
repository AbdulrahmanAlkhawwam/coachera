import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_context.dart';

class ExpansionList extends StatefulWidget {
  const ExpansionList({
    super.key,
    required this.children,
    required this.title,
  });

  final List<Widget> children;
  final String title;

  @override
  State<ExpansionList> createState() => _ExpansionListState();
}

class _ExpansionListState extends State<ExpansionList>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      onExpansionChanged: (expanded) =>
          setState(() => _isExpanded = !_isExpanded),
      initiallyExpanded: _isExpanded,
      trailing: Icon(
        _isExpanded ? TablerIcons.plus : TablerIcons.minus,
        color: context.colors.onSurface,
      ),
      title: Text(
        widget.title,
        style: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: widget.children,
    );
  }
}
