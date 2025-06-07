import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/res.dart';

class Screen extends StatelessWidget {
  const Screen({
    super.key,
    this.appBar,
    required this.body,
  });

  final AppBar? appBar;
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(Res.background),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: appBar,
            body: body,
          )
        ],
      ),
    );
  }
}
