import 'package:flutter/material.dart';
import 'package:flutter_template/dependency_injection/injection_container.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  MainAppBar({
    super.key,
  }) : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;
  final defaultShellStore = Managers.defaultShellStore;

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
