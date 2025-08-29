import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../core/utils/app_context.dart';

class Rate extends StatelessWidget {
  final double rate;
  final double? startSize;

  const Rate({
    super.key,
    required this.rate,
    this.startSize,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rate,
      itemBuilder: (context, index) => Icon(
        TablerIcons.star_filled,
        color: context.colors.secondary,
      ),
      itemCount: 5,
      itemSize: startSize ?? 22.0,
      unratedColor: Colors.grey[600],
      direction: Axis.horizontal,
    );
  }
}
