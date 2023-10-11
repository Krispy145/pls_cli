import 'package:flutter/material.dart';

/// [MainAppBar] is a class that defines the main app bar of the app.
class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// [MainAppBar] constructor.
  const MainAppBar({
    super.key,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Column(
        children: [
          Text("Flutter Template"),
        ],
      ),
    );
  }
}
