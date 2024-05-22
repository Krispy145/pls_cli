import * as vscode from "vscode";
import * as fs from "fs";
import { Uri, window } from "vscode";
import { getWorkspaceFilePath } from "../../utils/get-target-directory";
import {
  addInjectionAndGetter,
  appendAfterMarkerInContent,
  appendBeforeMarkerInContent,
} from "../../utils/add_to_files";
import { addFlutterPackageFromPath } from "../../utils/add_flutter_package";
import { compareGradleVersions } from "../../utils/compare_gradle_versions";
import {
  buildRunner,
  formatFiles,
  runCommandInWorkspaceFolder,
} from "../../utils/build_runner";

export const addNotifications = async (args: Uri) => {
  await updateAppDelegate(args);
  updateBuildGradle(args);
  updateAppBuildGradle(args);
  await updateAndroidManifest(args);
  await updateStringsXml(args);

  // Prompt user to select local, push, or both notification packages
  const notificationType = await vscode.window.showQuickPick(
    ["Local", "Push", "Both"],
    { placeHolder: "Select notification package type" }
  );
  const injectionContainerPath = getWorkspaceFilePath(
    args,
    "lib/dependencies/injection.dart"
  );

  var fileContent = fs.readFileSync(injectionContainerPath, "utf-8");
  // Add the selected notification package(s)
  if (notificationType === "Local" || notificationType === "Both") {
    fileContent = addLocalNotificationInjection(fileContent);
  }

  if (notificationType === "Push" || notificationType === "Both") {
    fileContent = addPushNotificationInjection(fileContent);
  }

  fs.writeFileSync(injectionContainerPath, fileContent);
  //

  // Add notification package(s) to pubspec.yaml
  const notificationsPath = "../../../packages/notifications";
  addFlutterPackageFromPath("notifications", notificationsPath);
  var runCommandResult;
  if (notificationType === "Local") {
    runCommandResult = await runCommandInWorkspaceFolder(
      args,
      "oasis add notifications_feature -s=local_notifications_store -r=local_store --is_push=false"
    );
  } else if (notificationType === "Push")
    runCommandResult = await runCommandInWorkspaceFolder(
      args,
      "oasis add notifications_feature -s=push_notifications_store -r=push_store --is_push=true"
    );
  else if (notificationType === "Both") {
    runCommandResult = await runCommandInWorkspaceFolder(
      args,
      "oasis add multi_notifications_feature"
    );
  }
  if (runCommandResult?.error !== undefined) {
    window.showErrorMessage(
      `Error running build runner: ${runCommandResult?.error}`
    );
  } else {
    window.showInformationMessage(
      `notifications feature created successfully.`
    );
  }
  await formatFiles(args);
  await buildRunner(args, "Notifications");

  // Open the docs/notifications.md file from the workspace root directory
  const docsPath = getWorkspaceFilePath(args, "docs/notifications.md");
  window.showTextDocument(Uri.file(docsPath));
};

async function updateAppDelegate(args: Uri) {
  try {
    // File path for AppDelegate.swift
    const appDelegatePath = getWorkspaceFilePath(
      args,
      "ios/Runner/AppDelegate.swift"
    );

    // Read the current content of AppDelegate.swift
    var currentContent = fs.readFileSync(appDelegatePath, "utf-8");

    // Code snippets to be added
    const requiredCodeSnippets = [
      "import flutter_local_notifications",
      `
      FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
      GeneratedPluginRegistrant.register(with: registry)
      }
      if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
      }`,
    ];

    for (const snippet of requiredCodeSnippets) {
      // Check if the snippet already exists in the file
      if (!currentContent.includes(snippet)) {
        // Find the markers for insertion points
        const importMarker = /(import Flutter)/;
        const codeMarker =
          /(\s*GeneratedPluginRegistrant\.register\(with: self\)\s*return super.application\(application, didFinishLaunchingWithOptions: launchOptions\))/;

        // Use appendAfterMarkerInFile and appendBeforeMarkerInFile as needed
        if (snippet === "import flutter_local_notifications") {
          currentContent = appendAfterMarkerInContent(
            currentContent,
            snippet,
            importMarker
          );
          vscode.window.showInformationMessage(
            "Notifications import code added to AppDelegate.swift"
          );
        } else {
          currentContent = appendBeforeMarkerInContent(
            currentContent,
            snippet,
            codeMarker
          );
          vscode.window.showInformationMessage(
            `Notifications GeneratedPluginRegistrant code added to AppDelegate.swift`
          );
        }
        fs.writeFileSync(appDelegatePath, currentContent);
      } else {
        vscode.window.showInformationMessage(
          `Notifications code in AppDelegate.swift include: ${snippet}`
        );
      }
    }

    vscode.window.showInformationMessage(
      "Notifications code added to AppDelegate.swift"
    );
  } catch (error) {
    vscode.window.showErrorMessage(`An error occurred: ${error}`);
  }
}

function updateBuildGradle(args: Uri) {
  const buildGradlePath = getWorkspaceFilePath(args, "android/build.gradle");

  try {
    // Read the current content of build.gradle
    let currentContent = fs.readFileSync(buildGradlePath, "utf-8");

    // Define the target Gradle version
    const targetGradleVersion = "7.3.1";

    // Create a regular expression to find the classpath in the dependencies block
    const classPathPattern =
      /classpath ['"](com.android.tools.build:gradle:([\d.]+))['"]/;

    // Use a regular expression to match and extract the existing classpath version
    const match = currentContent.match(classPathPattern);

    if (match) {
      const currentGradleVersion = match[2];
      if (
        compareGradleVersions(currentGradleVersion, targetGradleVersion) < 0
      ) {
        // Replace the Gradle version with the target version
        const updatedContent = currentContent.replace(
          classPathPattern,
          `classpath 'com.android.tools.build:gradle:${targetGradleVersion}'`
        );

        // Write the updated content back to the file
        fs.writeFileSync(buildGradlePath, updatedContent);

        console.log(`build.gradle updated to Gradle ${targetGradleVersion}`);
      } else {
        console.log(`Gradle version is already ${targetGradleVersion}`);
      }
    } else {
      console.error("Failed to locate the Gradle classpath in build.gradle");
    }
  } catch (error) {
    console.error(`An error occurred updating build.gradle: ${error}`);
  }
}

function updateAppBuildGradle(args: Uri) {
  const buildGradlePath = getWorkspaceFilePath(
    args,
    "android/app/build.gradle"
  );

  try {
    // Read the current content of build.gradle
    let currentContent = fs.readFileSync(buildGradlePath, "utf-8");

    // Define the code snippets to be added
    const codeToAddDefaultConfig = `
        multiDexEnabled true`;

    const codeToAddDependencies = `
    coreLibraryDesugaring 'com.android.tools:desugar_jdk_libs:2.0.3'`;

    const codeToAddToCompileOptions = `
        coreLibraryDesugaringEnabled true`;

    // Use regex to search for the defaultConfig block
    const defaultConfigIncludes = currentContent.includes(
      codeToAddDefaultConfig
    );
    const dependenciesIncludes = currentContent.includes(codeToAddDependencies);
    const compileOptionsIncludes = currentContent.includes(
      codeToAddToCompileOptions
    );

    if (!defaultConfigIncludes) {
      // Check the minSdkVersion
      const minSdkVersionMatch = currentContent.match(/minSdkVersion\s+(\d+)/);
      if (minSdkVersionMatch) {
        const minSdkVersion = parseInt(minSdkVersionMatch[1], 10);
        if (minSdkVersion < 33) {
          // Update minSdkVersion to 33
          currentContent = currentContent.replace(
            /minSdkVersion\s+(\d+)/,
            "minSdkVersion 33"
          );
        }
      }

      // Add the specified line to the defaultConfig block
      currentContent = appendAfterMarkerInContent(
        currentContent,
        codeToAddDefaultConfig,
        /(defaultConfig {)/
      );
    } else {
      vscode.window.showErrorMessage(
        "Failed to locate the defaultConfig block in build.gradle."
      );
    }

    if (!dependenciesIncludes) {
      // Add the specified line to the dependencies block
      currentContent = appendAfterMarkerInContent(
        currentContent,
        codeToAddDependencies,
        /(dependencies {)/
      );
    } else {
      vscode.window.showErrorMessage(
        "Failed to locate the dependencies block in build.gradle."
      );
    }

    if (!compileOptionsIncludes) {
      // Add the specified line to the dependencies block
      currentContent = appendAfterMarkerInContent(
        currentContent,
        codeToAddToCompileOptions,
        /(compileOptions {)/
      );
    } else {
      vscode.window.showErrorMessage(
        "Failed to locate the compile options block in build.gradle."
      );
    }
    fs.writeFileSync(buildGradlePath, currentContent);

    vscode.window.showInformationMessage(
      "build.gradle file updated successfully."
    );
  } catch (error) {
    vscode.window.showErrorMessage(
      `An error occurred updating build.gradle: ${error}`
    );
  }
}

async function updateAndroidManifest(args: Uri) {
  const manifestPath = getWorkspaceFilePath(
    args,
    "android/app/src/main/AndroidManifest.xml"
  );

  const permissionsBlock = `
    <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
    <uses-permission android:name="android.permission.VIBRATE"/>
    <uses-permission android:name="android.permission.USE_FULL_SCREEN_INTENT"/>
    <uses-permission android:name="android.permission.USE_EXACT_ALARM"/>
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE"/>
  `;

  const serviceBlock = `
      <service
          android:name="com.dexterous.flutterlocalnotifications.ForegroundService"        
          android:exported="false"
          android:stopWithTask="false"/>
      <receiver android:exported="false" android:name="com.dexterous.flutterlocalnotifications.ActionBroadcastReceiver" />
      <receiver android:exported="false" android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver" />
      <receiver android:exported="false" android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver">
          <intent-filter>
              <action android:name="android.intent.action.BOOT_COMPLETED"/>
              <action android:name="android.intent.action.MY_PACKAGE_REPLACED"/>
              <action android:name="android.intent.action.QUICKBOOT_POWERON" />
              <action android:name="com.htc.intent.action.QUICKBOOT_POWERON"/>
          </intent-filter>
      </receiver>
  `;

  const showWhenLockedAndTurnScreenOn = `
            android:showWhenLocked="true"
            android:turnScreenOn="true"
  `;

  const channelMetadata = `
          <!-- Local Notification Channel -->
          <meta-data
              android:name="com.dexterous.flutterlocalnotifications.notification_channel"
              android:resource="@string/local_notification_channel_id"
          />

          <!-- Push Notification Channel -->
          <meta-data
              android:name="com.google.firebase.messaging.default_notification_channel_id"
              android:resource="@string/push_notification_channel_id"
          />`;

  try {
    // Read the current content of AndroidManifest.xml
    let currentContent = fs.readFileSync(manifestPath, "utf-8");

    // Find the insertion point, which is after 'android:windowSoftInputMode="adjustResize">'
    const insertionIndex = currentContent.indexOf(
      'android:windowSoftInputMode="adjustResize">'
    );

    if (insertionIndex !== -1) {
      // Add permissions block below </application>
      currentContent = appendAfterMarkerInContent(
        currentContent,
        permissionsBlock,
        /(<uses-permission android:name="android\.permission\.INTERNET"\/>)/
      );

      // Add showWhenLockedAndTurnScreenOn attributes
      currentContent = appendAfterMarkerInContent(
        currentContent,
        showWhenLockedAndTurnScreenOn,
        /(android:windowSoftInputMode="adjustResize")/
      );

      // Add channelMetadata attributes
      currentContent = appendBeforeMarkerInContent(
        currentContent,
        channelMetadata,
        /(\s*<\/activity>)/
      );

      // Add the additional block before </application>
      currentContent = appendBeforeMarkerInContent(
        currentContent,
        serviceBlock,
        /(\s*<\/application>\s*<\/manifest>)/
      );

      fs.writeFileSync(manifestPath, currentContent);
      vscode.window.showInformationMessage(
        "Permissions and additional code added to AndroidManifest.xml"
      );
    } else {
      vscode.window.showErrorMessage(
        "Insertion point not found in AndroidManifest.xml"
      );
    }
  } catch (error) {
    vscode.window.showErrorMessage(`An error occurred: ${error}`);
  }
}

async function updateStringsXml(args: Uri) {
  const stringsXmlPath = getWorkspaceFilePath(
    args,
    "android/app/src/main/res/values/strings.xml"
  );
  const stringsToAdd = `
    <string name="local_notification_channel_id">local_notifications</string>
    <string name="push_notification_channel_id">push_notifications</string>
  `;

  try {
    let currentContent = "";
    if (fs.existsSync(stringsXmlPath)) {
      currentContent = fs.readFileSync(stringsXmlPath, "utf-8");
    }

    if (currentContent.includes(stringsToAdd)) {
      // Strings are already present, no need to add again
      return;
    }

    if (currentContent.trim() === "") {
      // File is empty, add XML declaration
      currentContent =
        '<?xml version="1.0" encoding="utf-8"?>\n<resources>\n</resources>';
    }

    // Find the insertion point, which is after <resources>
    const insertionIndex = currentContent.indexOf("<resources>");

    if (insertionIndex !== -1) {
      // Add the new strings below <resources>
      const updatedContent =
        currentContent.slice(0, insertionIndex + "<resources>".length) +
        stringsToAdd +
        "\n  " +
        currentContent.slice(insertionIndex + "<resources>".length);

      // Write the updated content back to the file
      fs.writeFileSync(stringsXmlPath, updatedContent);

      vscode.window.showInformationMessage("Strings added to strings.xml");
    } else {
      vscode.window.showErrorMessage(
        "Insertion point not found in strings.xml"
      );
    }
  } catch (error) {
    vscode.window.showErrorMessage(`An error occurred: ${error}`);
  }
}

function addLocalNotificationInjection(fileContent: string) {
  const injectionCode = `
  ..registerSingleton<LocalNotificationsStore>(
    LocalNotificationsStore()..initialize(),
  )`;

  const getterCode = `
  /// [NotificationsStore] getter
  T notificationsStore<T extends NotificationsStore>() {
    if (T == PushNotificationsStore) {
      return _serviceLocator.get<T>();
    } else if (T == LocalNotificationsStore) {
      return _serviceLocator.get<T>();
    } else {
      throw Exception("Invalid type for notificationsStore");
    }
  }`;

  fileContent = addInjectionAndGetter({
    fileContent: fileContent,
    storeName: "Local Notifications",
    importCode: `
      import 'package:notifications/stores/base_store.dart';
      import 'package:notifications/stores/local_store.dart';
      import 'package:notifications/stores/push_store.dart';
      `,
    injectionCode,
    getterCode,
    injectInto: "CORE", //change to EXTERNAL when changed logic to either add ..register... or add _serviceLocator..register...
  });

  return fileContent;
}

function addPushNotificationInjection(fileContent: string) {
  const injectionCode = `
  ..registerSingleton<PushNotificationsStore>(
    PushNotificationsStore()..initialize(),
  )`;

  const getterCode = `
  /// [NotificationsStore] getter
  T notificationsStore<T extends NotificationsStore>() {
    if (T == PushNotificationsStore) {
      return _serviceLocator.get<T>();
    } else if (T == LocalNotificationsStore) {
      return _serviceLocator.get<T>();
    } else {
      throw Exception("Invalid type for notificationsStore");
    }
  }`;

  fileContent = addInjectionAndGetter({
    fileContent: fileContent,
    storeName: "Push Notifications",
    importCode: `
  import 'package:notifications/stores/local_store.dart';
  import 'package:notifications/stores/base_store.dart';
  import 'package:notifications/stores/push_store.dart';`,
    injectionCode: injectionCode,
    getterCode: getterCode,
    injectInto: "CORE", //change to EXTERNAL when changed logic to either add ..register... or add _serviceLocator..register...
  });
  return fileContent;
}
