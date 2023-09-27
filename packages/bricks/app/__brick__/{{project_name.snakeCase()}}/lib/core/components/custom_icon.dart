import 'package:flutter/material.dart';

/// CustomIcon allows for non-square icons.
///
/// Use when downloaded [Custom Icons](https://www.fluttericon.com/) are not
/// square and therefore do not center properly.
class CustomIcon extends StatelessWidget {
  final double? fontSize;
  final IconData icon;
  final double? height;
  final double? width;
  final Color? color;
  final Alignment? alignment;

  const CustomIcon(
    this.icon, {
    Key? key,
    this.fontSize,
    this.height,
    this.width,
    this.color,
    this.alignment,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 24,
      width: width ?? 24,
      alignment: alignment ?? Alignment.center,
      // this is another weird hack to center a rectangle icon using a text widget
      child: Text(
        String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: fontSize ?? 24,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          color: color ?? Colors.black,
        ),
      ),
    );
  }
}
