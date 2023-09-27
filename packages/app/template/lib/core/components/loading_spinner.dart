import 'package:flutter/material.dart';

class LoadingSpinner extends StatelessWidget {
  final Alignment alignment;
  final double height;
  final double width;
  final Color? color;

  const LoadingSpinner({
    Key? key,
    this.alignment = Alignment.center,
    this.height = 30,
    this.width = 30,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: SizedBox(
        width: width,
        height: height,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
