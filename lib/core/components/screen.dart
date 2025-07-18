import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/res.dart';

class Screen extends StatelessWidget {
  const Screen({
    super.key,
    this.appBar,
    this.body,
    this.image,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.resizeToAvoidBottomInset = true,
  });

  final PreferredSizeWidget? appBar;
  final Widget? body;
  final String? image;
  final BoxFit fit;
  final double? width;
  final double? height;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            image ?? Res.background,
            width: width,
            height: height,
            fit: fit,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: appBar,
            body: body,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          ),
        ],
      ),
    );
  }
}
