import { Uri, window } from "vscode";
import {
  getWorkspaceFilePath,
  getTargetDirectory,
} from "../../utils/get-target-directory";
import * as fs from "fs";
import { appendBeforeMarkerInContent } from "../../utils/add_to_files";
import { addFlutterPackageFromPath } from "../../utils/add_flutter_package";
import { formatFiles } from "../../utils/build_runner";

export const addAdmob = async (args: Uri) => {
  try {
    await updateAndroidManifest(args);
    await updateIOSInfoPlist(args);
    await handleAdUnitIds(args);
    await formatFiles(args);
  } catch (error) {
    window.showErrorMessage(`An error occurred: ${error}`);
  }
};

const updateAndroidManifest = async (args: Uri) => {
  const androidAppId = await window.showInputBox({
    prompt: "Enter Android AdMob Application Identifier:",
    ignoreFocusOut: true,
  });
  while (androidAppId === undefined || androidAppId === "") {
    window.showErrorMessage(
      "Please enter a valid Android AdMob Application Identifier"
    );
  }
  const androidManifestPath = getWorkspaceFilePath(
    args,
    "android/app/src/main/AndroidManifest.xml"
  );
  var currentAndroidContent = fs.readFileSync(androidManifestPath, "utf-8");
  const androidManifestSnippet = `
        <!-- Admob -->
        <meta-data
            android:name="com.google.android.gms.ads.APPLICATION_ID"
            android:value="${androidAppId}"/>`;
  currentAndroidContent = appendBeforeMarkerInContent(
    currentAndroidContent,
    androidManifestSnippet,
    new RegExp("(\\s*)</application>\\s*</manifest>")
  );
  fs.writeFileSync(androidManifestPath, currentAndroidContent);
};

const updateIOSInfoPlist = async (args: Uri) => {
  const iosAppId = await window.showInputBox({
    prompt: "Enter iOS AdMob Application Identifier:",
    ignoreFocusOut: true,
  });
  while (iosAppId === undefined || iosAppId === "") {
    window.showErrorMessage(
      "Please enter a valid iOS AdMob Application Identifier"
    );
  }
  const iosInfoPlistPath = getWorkspaceFilePath(args, "ios/Runner/Info.plist");

  var currentIosContent = fs.readFileSync(iosInfoPlistPath, "utf-8");
  const iosInfoPlistSnippet = `
    <!-- Admob -->
    <key>GADApplicationIdentifier</key>
    <string>${iosAppId}</string>
    <key>io.flutter.embedded_views_preview</key>
    <true/>
    <key>NSUserTrackingUsageDescription</key>
    <string>This identifier will be used to deliver personalized ads to you.</string>`;
  currentIosContent = appendBeforeMarkerInContent(
    currentIosContent,
    iosInfoPlistSnippet,
    new RegExp("</dict>\n</plist>")
  );
  fs.writeFileSync(iosInfoPlistPath, currentIosContent);
};

const handleAdUnitIds = async (args: Uri) => {
  var bannerAdUnitId = await window.showInputBox({
    prompt: "Enter your Banner Ad Unit ID:",
    ignoreFocusOut: true,
  });
  var interstitialAdUnitId = await window.showInputBox({
    prompt: "Enter your Interstitial Ad Unit ID:",
    ignoreFocusOut: true,
  });
  var rewardAdUnitId = await window.showInputBox({
    prompt: "Enter your Reward Ad Unit ID:",
    ignoreFocusOut: true,
  });

  bannerAdUnitId = bannerAdUnitId ? bannerAdUnitId : undefined;
  interstitialAdUnitId = interstitialAdUnitId
    ? interstitialAdUnitId
    : undefined;
  rewardAdUnitId = rewardAdUnitId ? rewardAdUnitId : undefined;

  if (bannerAdUnitId || interstitialAdUnitId || rewardAdUnitId) {
    await updateInjectionContainer(
      args,
      bannerAdUnitId,
      interstitialAdUnitId,
      rewardAdUnitId
    );
  }
};

const updateInjectionContainer = async (
  args: Uri,
  bannerAdUnitId: string | undefined,
  interstitialAdUnitId: string | undefined,
  rewardAdUnitId: string | undefined
) => {
  const injectionContainerPath = getWorkspaceFilePath(
    args,
    "lib/dependencies/injection.dart"
  );
  const content = fs.readFileSync(injectionContainerPath, "utf-8");

  const importCode = "import 'package:admob/ads/store.dart';";

  const admobSetupCode = `
      ..registerLazySingleton<AdMobStore>(() => AdMobStore(bannerAdUnitId: '${
        bannerAdUnitId !== undefined ? "'" + bannerAdUnitId + "'" : null
      }',interstitialAdUnitId: '${
    interstitialAdUnitId !== undefined ? "'" + interstitialAdUnitId + "'" : null
  }',rewardAdUnitId: '${
    rewardAdUnitId !== undefined ? "'" + rewardAdUnitId + "'" : null
  }'))`;

  const getterCode = `
    /// [AdMobStore] getter
    AdMobStore get adMobStore => _serviceLocator.get<AdMobStore>();`;

  const updatedContent1 = content.replace(
    /(import .+;)(?!.*import .+;)/,
    `$1\n${importCode}`
  );

  const updatedContent2 = updatedContent1.replace(
    /(;\s*\n\s*\n\s*\/\/\/END OF CORE)/,
    `${admobSetupCode}$1`
  );

  const updatedContent3 = updatedContent2.replace(
    /(})(?![\s\S]*\})/,
    `${getterCode}\n$1`
  );

  fs.writeFileSync(injectionContainerPath, updatedContent3);

  const admobPath = "../../../packages/admob/";
  addFlutterPackageFromPath("admob", admobPath);
};
