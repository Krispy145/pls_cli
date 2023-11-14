import * as vscode from "vscode";
import * as fs from "fs";
import { exec } from "child_process";
import { Uri, window } from "vscode";
import {
  getFeatureFilePath as getFilePath,
  getTargetDirectory,
} from "../utils/get-target-directory";
import {
  appendAfterMarkerInFile,
  appendBeforeMarkerInFile,
} from "../utils/append_files";
import { addFlutterPackageFromPath } from "../utils/add_flutter_package";
import { compareGradleVersions } from "../utils/compare_gradle_versions";

export const addNotifications = async (args: Uri) => {
  var targetDir = await getTargetDirectory(args);
  updateAppDelegate();
  updateBuildGradle();
  updateAppBuildGradle();
  updateAndroidManifest();
  updateStringsXml();

  const notificationsPath =
    "/Users/davidkisbey-green/Desktop/Digital_Oasis/notifications/";
  addFlutterPackageFromPath("notifications", notificationsPath, targetDir);  
};

async function updateAppDelegate() {
  try {
    // File path for AppDelegate.swift
    const appDelegatePath = getFilePath("ios/Runner/AppDelegate.swift");

    // Read the current content of AppDelegate.swift
    const currentContent = fs.readFileSync(appDelegatePath, "utf-8");

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
        const importMarker = "import Flutter";
        const codeMarker =
          "GeneratedPluginRegistrant\\.register\\(with: self\\)\\s*return super.application\\(application, didFinishLaunchingWithOptions: launchOptions\\)";

        // Use appendAfterMarkerInFile and appendBeforeMarkerInFile as needed
        if (snippet === "import flutter_local_notifications") {
          await appendAfterMarkerInFile(appDelegatePath, snippet, importMarker);
          vscode.window.showInformationMessage(
            "Notifications import code added to AppDelegate.swift"
          );
        } else {
          await appendBeforeMarkerInFile(appDelegatePath, snippet, codeMarker);
          vscode.window.showInformationMessage(
            `Notifications GeneratedPluginRegistrant code added to AppDelegate.swift`
          );
        }
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

function updateBuildGradle() {
  const buildGradlePath = getFilePath("android/build.gradle");

  try {
    // Read the current content of build.gradle
    let currentContent = fs.readFileSync(buildGradlePath, "utf-8");

    // Define the target Gradle version
    const targetGradleVersion = "7.3.1";

    // Create a regular expression to find the classpath in the dependencies block
    const classpathPattern = /classpath ['"](com.android.tools.build:gradle:([\d.]+))['"]/;

    // Use a regular expression to match and extract the existing classpath version
    const match = currentContent.match(classpathPattern);

    if (match) {
      const currentGradleVersion = match[2];
      if (compareGradleVersions(currentGradleVersion, targetGradleVersion) < 0) {
        // Replace the Gradle version with the target version
        const updatedContent = currentContent.replace(
          classpathPattern,
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


function updateAppBuildGradle() {
  const buildGradlePath = getFilePath("android/app/build.gradle");

  try {
    // Read the current content of build.gradle
    let currentContent = fs.readFileSync(buildGradlePath, "utf-8");

    // Define the code snippets to be added
    const codeToAddDefaultConfig = `
        multiDexEnabled true`;

    const codeToAddDependencies = `
    coreLibraryDesugaring 'com.android.tools:desugar_jdk_libs:1.2.2'`;

    const codeToAddToCompileOptions = `
        coreLibraryDesugaringEnabled true`;

    // Define regular expression patterns to find the defaultConfig and dependencies blocks
    const defaultConfigPattern = "defaultConfig {";
    const dependenciesPattern = "dependencies {";
    const compileOptionsPattern = "compileOptions {";

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
          fs.writeFileSync(buildGradlePath, currentContent);
        }
      }
      // Add the specified line to the defaultConfig block
      appendAfterMarkerInFile(
        buildGradlePath,
        codeToAddDefaultConfig,
        defaultConfigPattern
      );
    } else {
      vscode.window.showErrorMessage(
        "Failed to locate the defaultConfig block in build.gradle."
      );
    }

    if (!dependenciesIncludes) {
      // Add the specified line to the dependencies block
      appendAfterMarkerInFile(
        buildGradlePath,
        codeToAddDependencies,
        dependenciesPattern
      );
    } else {
      vscode.window.showErrorMessage(
        "Failed to locate the dependencies block in build.gradle."
      );
    }

    if (!compileOptionsIncludes) {
      // Add the specified line to the dependencies block
      appendAfterMarkerInFile(
        buildGradlePath,
        codeToAddToCompileOptions,
        compileOptionsPattern
      );
    } else {
      vscode.window.showErrorMessage(
        "Failed to locate the compile options block in build.gradle."
      );
    }

    vscode.window.showInformationMessage(
      "build.gradle file updated successfully."
    );
  } catch (error) {
    vscode.window.showErrorMessage(
      `An error occurred updating build.gradle: ${error}`
    );
  }
}

async function updateAndroidManifest() {
  const manifestPath = getFilePath("android/app/src/main/AndroidManifest.xml");

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

const channelMetadata =`
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
      // Add the additional block before </application>
      await appendBeforeMarkerInFile(
        manifestPath,
        serviceBlock,
        "(\\s*)</application>\\s*</manifest>"
      );

      // Add permissions block below </application>
      await appendAfterMarkerInFile(
        manifestPath,
        permissionsBlock,
        `<uses-permission android:name="android.permission.INTERNET"/>`
      );

      // Add showWhenLockedAndTurnScreenOn attributes
      await appendAfterMarkerInFile(
        manifestPath,
        showWhenLockedAndTurnScreenOn,
        'android:windowSoftInputMode="adjustResize"'
      );

      vscode.window.showInformationMessage(
        "Permissions and additional code added to AndroidManifest.xml"
      );

      // Add channelMetadata attributes
      await appendBeforeMarkerInFile(
        manifestPath,
        channelMetadata,
        "(\\s*)</activity>"
      );

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

async function updateStringsXml() {
  const stringsXmlPath = getFilePath(
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
