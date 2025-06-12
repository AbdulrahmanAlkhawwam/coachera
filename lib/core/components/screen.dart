import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/res.dart';

class Screen extends StatelessWidget {
  const Screen({
    super.key,
    this.appBar,
    this.body,
    this.resizeToAvoidBottomInset = true,
  });

  final PreferredSizeWidget? appBar;
  final Widget? body;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            Res.background,
            fit: BoxFit.cover,
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
