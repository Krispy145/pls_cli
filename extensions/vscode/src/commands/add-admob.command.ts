import { exec } from "child_process";
import { Uri, window } from "vscode";
import {
  getFeatureFilePath as getFilePath,
  getTargetDirectory,
} from "../utils/get-target-directory";
import * as fs from "fs";
import { appendBeforeMarkerInFile } from "../utils/append_files";
import { addFlutterPackageFromPath } from "../utils/add_flutter_package";

export const addAdmob = async (args: Uri) => {
  var targetDir = await getTargetDirectory(args);
  try {
    const androidManifestPath = getFilePath(
      "android/app/src/main/AndroidManifest.xml"
    );
    const iosInfoPlistPath = getFilePath("ios/Runner/Info.plist");

    const androidAppId = await window.showInputBox({
      prompt: "Enter Android AdMob Application Identifier:",
    });

    const iosAppId = await window.showInputBox({
      prompt: "Enter iOS AdMob Application Identifier:",
    });

    if (androidAppId && iosAppId) {
      // Add AndroidManifest.xml snippet
      const androidManifestSnippet = `
        <!-- Admob -->
        <meta-data
            android:name="com.google.android.gms.ads.APPLICATION_ID"
            android:value="${androidAppId}"/>`;
      await appendBeforeMarkerInFile(
        androidManifestPath,
        androidManifestSnippet,
        "(\\s*)</application>\\s*</manifest>"
      );

      // Add iOS Info.plist snippet
      const iosInfoPlistSnippet = `
    <!-- Admob -->
    <key>GADApplicationIdentifier</key>
    <string>${iosAppId}</string>
    <key>io.flutter.embedded_views_preview</key>
    <true/>
    <key>NSUserTrackingUsageDescription</key>
    <string>This identifier will be used to deliver personalized ads to you.</string>`;
      await appendBeforeMarkerInFile(
        iosInfoPlistPath,
        iosInfoPlistSnippet,
        "</dict>\n</plist>"
      );

      var bannerAdUnitId = await window.showInputBox({
        prompt: "Enter your Banner Ad Unit ID:",
      });
      var interstitialAdUnitId = await window.showInputBox({
        prompt: "Enter your Interstitial Ad Unit ID:",
      });
      var rewardAdUnitId = await window.showInputBox({
        prompt: "Enter your Reward Ad Unit ID:",
      });

      bannerAdUnitId = "" ? undefined : bannerAdUnitId;
      interstitialAdUnitId = "" ? undefined : interstitialAdUnitId;
      rewardAdUnitId = "" ? undefined : rewardAdUnitId;
      if (bannerAdUnitId || interstitialAdUnitId || rewardAdUnitId) {
        // Import statement to be added
        const importCode = "import 'package:admob/ads/store.dart';";

        // Code snippet to be added
        //TODO: Replace the AdMob IDs with the helper variables
        const admobSetupCode = `
      ..registerLazySingleton<AdMobStore>(() => AdMobStore(bannerAdUnitId: '${
        bannerAdUnitId !== undefined ? "'" + bannerAdUnitId + "'" : null
      }',interstitialAdUnitId: '${
          interstitialAdUnitId !== undefined
            ? "'" + interstitialAdUnitId + "'"
            : null
        }',rewardAdUnitId: '${
          rewardAdUnitId !== undefined ? "'" + rewardAdUnitId + "'" : null
        }'))`;

        // Getter to be added
        const getterCode = `
    /// [AdMobStore] getter
    AdMobStore get adMobStore => _serviceLocator.get<AdMobStore>();`;

        const injectionContainerPath = getFilePath(
          "lib/dependencies/injection.dart"
        );
        const content = fs.readFileSync(injectionContainerPath, "utf-8");

        // Add the import statement after the last import
        const updatedContent1 = content.replace(
          /(import .+;)(?!.*import .+;)/,
          `$1\n${importCode}`
        );

        // Find the comment "///END OF CORE" and insert the AdMob setup code just before it
        const updatedContent2 = updatedContent1.replace(
          /(;\s*\n\s*\n\s*\/\/\/END OF CORE)/,
          `${admobSetupCode}$1`
        );

        // Add the getter at the end of the class
        const updatedContent3 = updatedContent2.replace(
          /(})(?![\s\S]*\})/,
          `${getterCode}\n$1`
        );

        fs.writeFileSync(injectionContainerPath, updatedContent3);

        const admobPath =
          "/Users/davidkisbey-green/Desktop/Digital_Oasis/admob/";
        addFlutterPackageFromPath("admob", admobPath, targetDir);
        // const cmd = `flutter pub add admob --path=${admobPath}`;

        // exec(cmd, { cwd: targetDir }, (error, stdout, stderr) => {
        //   if (error) {
        //     console.error(`Error: ${error.message}`);
        //     window.showErrorMessage(`Error: ${error.message}`);
        //     return;
        //   }
        //   if (stderr) {
        //     console.error(`stderr: ${stderr}`);
        //     window.showErrorMessage(`stderr: ${stderr}`);
        //     return;
        //   }
        //   console.log(`stdout: ${stdout}`);
        //   window.showInformationMessage("AdMob package added to dependencies");
        // });
      }
    }
  } catch (error) {
    window.showErrorMessage(`An error occurred: ${error}`);
  }
};
