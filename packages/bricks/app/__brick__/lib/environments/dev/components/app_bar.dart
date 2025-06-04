import "package:{{project_name.snakeCase()}}/dependencies/injection.dart";
import "package:flutter/material.dart";
import "package:flutter_mobx/flutter_mobx.dart";
import "package:theme/presentation/changer/changer.dart";

/// [DevAppBar] is a class that defines the main app bar of the app.
class DevAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// [DevAppBar] constructor.
  DevAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  final store = Managers.config;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return SafeArea(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: store.showDevTools ? preferredSize.height : 0,
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  height: preferredSize.height,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: Managers.themeStateStore.toggleThemeMode,
                        icon: Icon(Icons.brightness_4, size: store.showDevTools ? 24 : 0),
                      ),
                      TextButton.icon(
                        onPressed: () => ThemeChanger.currentColorThemeChanger(context: context),
                        icon: Icon(Icons.palette, size: store.showDevTools ? 24 : 0),
                        label: const Text("Colors"),
                      ),
                      TextButton.icon(
                        onPressed: () => ThemeChanger.currentColorThemeFromImageChanger(context: context),
                        icon: Icon(Icons.upload_file_outlined, size: store.showDevTools ? 24 : 0),
                        label: const Text("Colors from Image"),
                      ),

                      TextButton.icon(
                        onPressed: () => ThemeChanger.currentTextStylesThemeChanger(context: context),
                        icon: Icon(Icons.text_fields_rounded, size: store.showDevTools ? 24 : 0),
                        label: const Text("Text Styles"),
                      ),

                      TextButton.icon(
                        onPressed: () {
                          ThemeChanger.currentThemeChanger(context: context);
                        },
                        icon: Icon(Icons.more_horiz_rounded, size: store.showDevTools ? 24 : 0),
                        label: const Text("Components"),
                      ),

                      TextButton.icon(
                        onPressed: ThemeChanger.saveJsonToFile,
                        icon: Icon(Icons.download, size: store.showDevTools ? 24 : 0),
                        label: const Text("Download"),
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
              ),
            ),
          ),
        );
      },
    );
  }
}
