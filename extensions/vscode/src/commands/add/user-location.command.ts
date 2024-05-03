import * as vscode from "vscode";
import * as fs from "fs";
import { Uri, window } from "vscode";
import { getWorkspaceFilePath } from "../../utils/get-target-directory";
import {
  addInjectionAndGetter,
  appendAfterMarkerInContent,
  appendBeforeMarkerInContent,
} from "../../utils/add_to_files";
import { formatFiles } from "../../utils/build_runner";

export const addUserLocation = async (args: Uri) => {
  try {
    var message = await window.showInputBox({
      prompt: "Location usage description",
      placeHolder: "This app needs access to location when open.",
      ignoreFocusOut: true,
    });

    if (!message) {
      message = "This app needs access to location when open.";
    }

    updateAndroidManifest(args);
    await updateIosInfoPlist(args, message);
    updateMacOsInfoPlist(args, message);
    updateProfileEntitlements(args);
    addLocationInjection(args);
    await formatFiles(args);
  } catch (error) {
    window.showErrorMessage(`Error: ${error}`);
  }
};

function updateAndroidManifest(args: Uri) {
  const manifestPath = getWorkspaceFilePath(
    args,
    "android/app/src/main/AndroidManifest.xml"
  );

  const permissionsBlock = `
        <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
        <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
        <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />
      `;

  try {
    // Read the current content of AndroidManifest.xml
    let currentContent = fs.readFileSync(manifestPath, "utf-8");

    // Add permissions block below </application>
    currentContent = appendAfterMarkerInContent(
      currentContent,
      permissionsBlock,
      /(<uses-permission android:name="android\.permission\.INTERNET"\/>)/
    );

    fs.writeFileSync(manifestPath, currentContent);
    vscode.window.showInformationMessage(
      "Permissions added to AndroidManifest.xml"
    );
  } catch (error) {
    vscode.window.showErrorMessage(`An error occurred: ${error}`);
  }
}

async function updateIosInfoPlist(args: Uri, message: string) {
  const infoPlistPath = getWorkspaceFilePath(args, "ios/Runner/Info.plist");
  var infoPlistContent = fs.readFileSync(infoPlistPath, "utf8");

  const receiveLocationUpdatesInBackground = await window.showQuickPick(
    ["Yes", "No"],
    {
      placeHolder: "Do you want to receive location updates in background",
      ignoreFocusOut: true,
    }
  );

  var newContent = `    
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>${message}</string>
    `;

  if (receiveLocationUpdatesInBackground) {
    newContent += `
        <key>NSLocationTemporaryUsageDescriptionDictionary</key>
        <dict>
            <key>YourPurposeKey</key>
            <string>The example App requires temporary access to the device&apos;s precise location.</string>
        </dict>
        `;
  }

  infoPlistContent = appendBeforeMarkerInContent(
    infoPlistContent,
    newContent,
    /(\s*<\/dict>\s*<\/plist>)/
  );
  fs.writeFileSync(infoPlistPath, infoPlistContent);
}

function updateMacOsInfoPlist(args: Uri, message: string) {
  const infoPlistPath = getWorkspaceFilePath(args, "macos/Runner/Info.plist");
  var infoPlistContent = fs.readFileSync(infoPlistPath, "utf8");

  var newContent = `    
          <key>NSLocationUsageDescription</key>
          <string>${message}</string>
    `;

  infoPlistContent = appendBeforeMarkerInContent(
    infoPlistContent,
    newContent,
    /(\s*<\/dict>\s*<\/plist>)/
  );
  fs.writeFileSync(infoPlistPath, infoPlistContent);
}

function updateProfileEntitlements(args: Uri) {
  var newContent = `    
      <key>com.apple.security.personal-information.location</key>
      <true/>
    `;

  const debugEntitlementsPath = getWorkspaceFilePath(
    args,
    "macos/Runner/DebugProfile.entitlements"
  );

  var debugEntitlementsContent = fs.readFileSync(debugEntitlementsPath, "utf8");

  debugEntitlementsContent = appendBeforeMarkerInContent(
    debugEntitlementsContent,
    newContent,
    /(\s*<\/dict>\s*<\/plist>)/
  );
  fs.writeFileSync(debugEntitlementsPath, debugEntitlementsContent);

  const releaseEntitlementsPath = getWorkspaceFilePath(
    args,
    "macos/Runner/DebugProfile.entitlements"
  );

  var releaseEntitlementsContent = fs.readFileSync(
    releaseEntitlementsPath,
    "utf8"
  );

  releaseEntitlementsContent = appendBeforeMarkerInContent(
    releaseEntitlementsContent,
    newContent,
    /(\s*<\/dict>\s*<\/plist>)/
  );
  fs.writeFileSync(releaseEntitlementsPath, releaseEntitlementsContent);
}

function addLocationInjection(args: Uri) {
  const injectionContainerPath = getWorkspaceFilePath(
    args,
    "lib/dependencies/injection.dart"
  );
  var fileContent = fs.readFileSync(injectionContainerPath, "utf-8");

  const injectionCode = `
  ..registerLazySingleton(UserLocationStore.new)
  `;

  const getterCode = `
  /// [UserLocationStore] getter
  UserLocationStore get userLocationStore => _serviceLocator.get<UserLocationStore>();
  `;

  fileContent = addInjectionAndGetter({
    fileContent: fileContent,
    storeName: "Push Notifications",
    importCode: `
  import "package:utilities/stores/user_location_store.dart";
  `,
    injectionCode: injectionCode,
    getterCode: getterCode,
    injectInto: "APP",
  });

  fs.writeFileSync(injectionContainerPath, fileContent);
}
