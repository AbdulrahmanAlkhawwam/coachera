import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/res.dart';

class AppImage extends StatefulWidget {
  final String? url;
  final double? width;
  final double? height;
  final Alignment? alignment;
  final BoxFit? fit;
  final Widget? errorWidget;
  final Widget? placeholder;
  final double? placeholderHeight;
  final double? placeholderWidth;
  final Color? color;

  const AppImage(
    this.url, {
    super.key,
    this.width,
    this.height,
    this.alignment,
    this.fit,
    this.errorWidget,
    this.placeholder,
    this.placeholderHeight,
    this.placeholderWidth,
    this.color,
  });

  @override
  State<AppImage> createState() => _AppImageState();
}

class _AppImageState extends State<AppImage>
    with SingleTickerProviderStateMixin {
  late final Animation<double> animation;
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = CurvedAnimation(
        parent: controller, curve: Curves.easeIn, reverseCurve: Curves.easeOut);
    controller.repeat(min: 0.5, max: 0.8, reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.url == null) {
      return widget.errorWidget ?? placeholder();
    }

    if (widget.url!.startsWith("assets")) {
      return widget.url!.contains(".svg")
          ? SvgPicture.asset(
              widget.url!,
              width: widget.width,
              height: widget.height,
              alignment: widget.alignment ?? Alignment.center,
              placeholderBuilder: (_) => placeholder(withAnimation: true),
              colorFilter: widget.color == null
                  ? null
                  : ColorFilter.mode(widget.color!, BlendMode.srcIn),
            )
          : Image.asset(
              widget.url!,
              width: widget.width,
              height: widget.height,
              alignment: widget.alignment ?? Alignment.center,
              fit: widget.fit ?? BoxFit.cover,
              errorBuilder: (_, __, ___) => widget.errorWidget ?? placeholder(),
              frameBuilder: (_, child, frame, loaded) =>
                  frame != null ? child : placeholder(withAnimation: true),
              color: widget.color,
              colorBlendMode: widget.color == null ? null : BlendMode.srcIn,
            );
    }

    if (widget.url!.startsWith("http")) {
      return widget.url!.contains(".svg")
          ? SvgPicture.network(
              widget.url!,
              width: widget.width,
              height: widget.height,
              alignment: widget.alignment ?? Alignment.center,
              placeholderBuilder: (_) => placeholder(withAnimation: true),
              colorFilter: widget.color == null
                  ? null
                  : ColorFilter.mode(widget.color!, BlendMode.srcIn),
            )
          : Image.network(
              widget.url!,
              width: widget.width,
              height: widget.height,
              alignment: widget.alignment ?? Alignment.center,
              fit: widget.fit ?? BoxFit.cover,
              errorBuilder: (_, __, ___) => widget.errorWidget ?? placeholder(),
              frameBuilder: (_, child, frame, loaded) =>
                  frame != null ? child : placeholder(withAnimation: true),
              color: widget.color,
              colorBlendMode: widget.color == null ? null : BlendMode.srcIn,
            );
    }

    return widget.errorWidget ?? placeholder();
  }

  Widget placeholder({bool withAnimation = false}) =>
      widget.placeholder ??
      Container(
        width: widget.placeholderWidth ?? widget.width,
        height: widget.placeholderHeight ?? widget.height,
        alignment: Alignment.center,
        child: Image.asset(
          Res.spaceHolder,
          width: widget.width != null ? min(widget.width! - 20, 100) : 100,
          opacity:
              withAnimation ? animation : const AlwaysStoppedAnimation(0.5),
        ),
      );
}
