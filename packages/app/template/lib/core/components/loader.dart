import 'package:flutter/material.dart';

/// [Loader] is a widget that swaps it's child for a loading indicator when the
/// [isLoading] param is true;
class Loader extends StatelessWidget {
  final Widget child;

  /// Whether a widget is loading or not.
  final bool isLoading;

  /// The size of the [CircularProgressIndicator] if no custom [loadingWidget]
  /// is provided.
  final double progressIndicatorSize;

  /// The color of the [CircularProgressIndicator] if no custom [loadingWidget]
  /// is provided.
  final Color? progressIndicatorColor;

  /// Customise the loading widget.
  ///
  /// Defaults to a [CircularProgressIndicator].
  final Widget? loadingWidget;

  const Loader({
    Key? key,
    required this.child,
    this.progressIndicatorColor,
    this.progressIndicatorSize = 20,
    this.isLoading = false,
    this.loadingWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return loadingWidget ??
          SizedBox(
            height: progressIndicatorSize,
            width: progressIndicatorSize,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                progressIndicatorColor ?? Colors.black,
              ),
            ),
          );
    }

    return child;
  }
}
