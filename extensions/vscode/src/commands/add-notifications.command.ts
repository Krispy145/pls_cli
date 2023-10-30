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

export const addNotifications = async (args: Uri) => {
  var targetDir = await getTargetDirectory(args);
  updateAppDelegate();
  updateBuildGradle();
  updateAndroidManifest();
  updateStringsXml();
  const notificationsPath =
    "/Users/davidkisbey-green/Desktop/Digital_Oasis/notifications/";
  const cmd = `flutter pub add notifications --path=${notificationsPath}`;
  exec(cmd, { cwd: targetDir }, (error, stdout, stderr) => {
    if (error) {
      console.error(`Error: ${error.message}`);
      window.showErrorMessage(`Error: ${error.message}`);
      return;
    }
    if (stderr) {
      console.error(`stderr: ${stderr}`);
      window.showErrorMessage(`stderr: ${stderr}`);
      return;
    }
    console.log(`stdout: ${stdout}`);
    window.showInformationMessage(
      "Notifications package added to dependencies"
    );
  });
};

function updateAppDelegate() {
  try {
    // File path for AppDelegate.swift
    const appDelegatePath = getFilePath("ios/Runner/AppDelegate.swift");

    // Read the current content of AppDelegate.swift
    const currentContent = fs.readFileSync(appDelegatePath, "utf-8");

    // Code snippets to be added
    const requiredCodeSnippets = [
      "import flutter_local_notifications",
      "FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in",
      "GeneratedPluginRegistrant.register(with: registry)",
      "if #available(iOS 10.0, *) {",
      "UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate",
    ];

    // Find the last import statement to add the import flutter_local_notifications below it
    const lastImportIndex = currentContent.lastIndexOf("import");

    let updatedContent = currentContent;

    for (const snippet of requiredCodeSnippets) {
      if (!currentContent.includes(snippet)) {
        // Find the insertion point and add the code snippet
        const insertionIndex = currentContent.indexOf(
          "GeneratedPluginRegistrant.register(with: self)"
        );
        if (insertionIndex !== -1) {
          updatedContent = `${currentContent.slice(
            0,
            insertionIndex
          )}\n${snippet}\n${currentContent.slice(insertionIndex)}`;
        } else if (lastImportIndex !== -1) {
          updatedContent = `${
            currentContent.slice(0, lastImportIndex) + snippet
          }\n${currentContent.slice(lastImportIndex)}`;
        }
      }
    }

    if (updatedContent !== currentContent) {
      // Write the updated content to the file
      fs.writeFileSync(appDelegatePath, updatedContent);

      vscode.window.showInformationMessage(
        "Notifications code added to AppDelegate.swift"
      );
    } else {
      vscode.window.showInformationMessage(
        "Notifications code is already present in AppDelegate.swift"
      );
    }
  } catch (error) {
    vscode.window.showErrorMessage(`An error occurred: ${error}`);
  }
}

function updateBuildGradle() {
  const buildGradlePath = getFilePath("android/app/build.gradle");

  try {
    // Read the current content of build.gradle
    let currentContent = fs.readFileSync(buildGradlePath, "utf-8");

    // Define the code snippets to be added
    const codeToAddDefaultConfig = `
          multiDexEnabled true
`;

    const codeToAddDependencies = `
  coreLibraryDesugaring 'com.android.tools:desugar_jdk_libs:1.2.2'
`;

    // Define regular expression patterns to find the defaultConfig and dependencies blocks
    const defaultConfigPattern = /defaultConfig\s*\{([\s\S]*?)\}/;
    const dependenciesPattern = /dependencies\s*\{([\s\S]*?)\}/;

    // Use regex to search for the defaultConfig block
    const defaultConfigMatches = currentContent.match(defaultConfigPattern);
    const dependenciesMatches = currentContent.match(dependenciesPattern);

    if (defaultConfigMatches) {
      // Add the specified line to the defaultConfig block
      appendAfterMarkerInFile(
        buildGradlePath,
        codeToAddDefaultConfig,
        defaultConfigMatches[0]
      );

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
    } else {
      vscode.window.showErrorMessage(
        "Failed to locate the defaultConfig block in build.gradle."
      );
    }

    if (dependenciesMatches) {
      // Add the specified line to the dependencies block
      appendBeforeMarkerInFile(
        buildGradlePath,
        codeToAddDependencies,
        dependenciesMatches[0]
      );
    } else {
      vscode.window.showErrorMessage(
        "Failed to locate the dependencies block in build.gradle."
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

  const additionalBlock = `
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
      <!-- Local Notification Channel -->
    <meta-data
        android:name="com.dexterous.flutterlocalnotifications.notification_channel"
        android:resource="@string/local_notification_channel_id"
    />

    <!-- Push Notification Channel -->
    <meta-data
        android:name="com.dexterous.flutterlocalnotifications.notification_channel"
        android:resource="@string/push_notification_channel_id"
    />
  `;

  try {
    // Read the current content of AndroidManifest.xml
    let currentContent = fs.readFileSync(manifestPath, "utf-8");

    // Find the insertion point, which is after 'android:windowSoftInputMode="adjustResize">'
    const insertionIndex = currentContent.indexOf(
      'android:windowSoftInputMode="adjustResize">'
    );

    if (insertionIndex !== -1) {
      // Add the additional block before </application>
      await appendBeforeMarkerInFile(manifestPath, additionalBlock, "</application>");

      // Add permissions block below </application>
      await appendAfterMarkerInFile(manifestPath, permissionsBlock, "</application>");

      // Add showWhenLockedAndTurnScreenOn attributes
      await appendBeforeMarkerInFile(manifestPath, showWhenLockedAndTurnScreenOn, 'android:windowSoftInputMode="adjustResize">');

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
  const stringsXmlPath = getFilePath("android/app/src/main/res/values/strings.xml");
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
      currentContent = '<?xml version="1.0" encoding="utf-8"?>\n<resources>\n</resources>';
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
