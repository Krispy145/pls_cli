import "package:app_template/dependencies/injection.dart";
import "package:flutter/material.dart";
import "package:theme/presentation/changer/changer.dart";
import "package:theme/presentation/components/select_theme/view.dart";

/// [DevAppBar] is a class that defines the main app bar of the app.
class DevAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// [DevAppBar] constructor.
  const DevAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: Managers.themeStateStore.toggleThemeMode,
              icon: const Icon(Icons.brightness_4),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 200),
              child: SelectThemeField(),
            ),
            TextButton.icon(
              onPressed: () => ThemeChanger.currentColorThemeChanger(context: context),
              icon: const Icon(Icons.palette),
              label: const Text("Colors"),
            ),
            TextButton.icon(
              onPressed: () => ThemeChanger.currentColorThemeFromImageChanger(context: context),
              icon: const Icon(Icons.upload_file_outlined),
              label: const Text("Colors from Image"),
            ),

            TextButton.icon(
              onPressed: () => ThemeChanger.currentTextStylesThemeChanger(context: context),
              icon: const Icon(Icons.text_fields_rounded),
              label: const Text("Text Styles"),
            ),

            TextButton.icon(
              onPressed: () {
                ThemeChanger.currentThemeChanger(context: context);
              },
              icon: const Icon(Icons.more_horiz_rounded),
              label: const Text("Components"),
            ),

            TextButton.icon(
              onPressed: ThemeChanger.updateThemeInRepository,
              icon: const Icon(Icons.save),
              label: const Text("Save to DB"),
            ),

            TextButton.icon(
              onPressed: ThemeChanger.saveJsonToFile,
              icon: const Icon(Icons.download),
              label: const Text("Download"),
            ),

            TextButton.icon(
              onPressed: () => ThemeChanger.saveJsonToDatabase(context),
              icon: const Icon(Icons.upload),
              label: const Text("Upload to DO"),
            ),

            // / Uncomment the following code to enable the upload button.
            // / This button will upload the current theme to the repository.
            // / NB: Useful only when uploading from assets to a backend database.
            // Sizes.s.spacer(vertical: false),
            // IconButton(
            //   onPressed: () => ThemeChanger.updateThemeInRepository(
            //     repository: ThemeRepository(
            //       // baseThemeConfiguration: const ThemeConfiguration.firestore(
            //       //   collectionName: "baseThemes",
            //       // ),
            //       componentThemesConfiguration: const ThemeConfiguration.firestore(
            //         collectionName: "componentsThemes",
            //       ),
            //     ),
            //   ),
            //   icon: const Icon(Icons.upload),
            // ),
          ],
        ),
      ),
    );
  }
}
