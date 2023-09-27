import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;
  final Color baseColor;
  final Color highlightColor;

  LoadingShimmer.rect({
    Key? key,
    this.width = double.infinity,
    required this.height,
    this.shapeBorder = const RoundedRectangleBorder(),
  })  : baseColor = Colors.black.withOpacity(0.25),
        highlightColor = Colors.black.withOpacity(0.15),
        super(key: key);

  LoadingShimmer.circularIcon({
    Key? key,
    required this.width,
    required this.height,
    this.shapeBorder = const CircleBorder(),
  })  : baseColor = const Color(0xff161B4B),
        highlightColor = const Color(0xFF161B4B).withOpacity(0.7),
        super(key: key);

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(color: baseColor, shape: shapeBorder),
        ),
      );
}
