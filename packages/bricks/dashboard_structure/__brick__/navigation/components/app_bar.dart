import 'package:flutter/material.dart';

/// [MainAppBar] is a class that defines the main app bar of the app.
class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// [MainAppBar] constructor.
  const MainAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("App Template"),
    );
  }
}
