import "package:flutter/material.dart";
import "package:theme/presentation/changer/changer.dart";
import "package:utilities/sizes/spacers.dart";

/// [DevAppBar] is a class that defines the main app bar of the app.
class DevAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// [DevAppBar] constructor.
  const DevAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(36);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => ThemeChanger.currentThemeChanger(context: context),
            icon: const Icon(Icons.palette),
          ),
          Sizes.s.spacer(vertical: false),
          const IconButton(
            onPressed: ThemeChanger.updateThemeInRepository,
            icon: Icon(Icons.save),
          ),
        ],
      ),
    );
  }
}
