import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/utils/app_context.dart';

class Rate extends StatelessWidget {
  final double rate;
  final double? startSize;
  final bool loading;

  const Rate({
    super.key,
    this.rate = 0,
    this.startSize,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return _shimmerRate(context);
    }

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

  Widget _shimmerRate(BuildContext context) => Shimmer.fromColors(
        baseColor: context.colors.surface,
        highlightColor: context.colors.primaryContainer,
        child: RatingBarIndicator(
          rating: 5,
          itemBuilder: (context, index) => Icon(TablerIcons.star_filled),
          itemCount: 5,
          itemSize: startSize ?? 22.0,
          direction: Axis.horizontal,
        ),
      );
}
