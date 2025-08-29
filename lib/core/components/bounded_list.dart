import 'package:flutter/material.dart';

import '../utils/app_context.dart';

class BoundedList extends StatelessWidget {
  final EdgeInsets? padding;
  final Widget? child;
  final List<Widget>? children;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;

  const BoundedList({
    super.key,
    this.padding,
    this.child,
    this.children,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
  }) : assert(child != null || children != null,
            "You must provide either child or children");

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bottomPadding = context.bottomPadding;
        return SingleChildScrollView(
          padding: padding?.copyWith(
                bottom: (padding?.bottom ?? 0) + bottomPadding,
              ) ??
              EdgeInsets.only(bottom: bottomPadding),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              minHeight: constraints.maxHeight -
                  (padding?.bottom ?? 0) -
                  (padding?.top ?? 0) -
                  bottomPadding,
            ),
            child: IntrinsicHeight(
              child: child ??
                  Column(
                      crossAxisAlignment:
                          crossAxisAlignment ?? CrossAxisAlignment.stretch,
                      mainAxisAlignment:
                          mainAxisAlignment ?? MainAxisAlignment.start,
                      children: children!),
            ),
          ),
        );
      },
    );
  }
}
