import * as vscode from "vscode";
import * as fs from "fs";
import { exec } from "child_process";
import { Uri, window } from "vscode";
import {
  getFeatureFilePath as getFilePath,
  getTargetDirectory,
} from "../utils/get-target-directory";

export const addNotifications = async (args: Uri) => {
  var targetDir = await getTargetDirectory(args);
  updateAppDelegate();
  updateBuildGradle();
  updateAndroidManifest();
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
    }, 
    compileOptions {
        // Flag to enable support for the new language APIs
        coreLibraryDesugaringEnabled true
        // Sets Java compatibility to Java 8
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }
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
      // Replace the closing brace (}) with the code snippet for defaultConfig
      currentContent = currentContent.replace(
        defaultConfigMatches[0],
        defaultConfigMatches[0].replace("}", codeToAddDefaultConfig)
      );
    } else {
      vscode.window.showErrorMessage(
        "Failed to locate the defaultConfig block in build.gradle."
      );
    }

    if (dependenciesMatches) {
      // Add the specified line to the dependencies block
      currentContent = currentContent.replace(
        dependenciesMatches[0],
        `${dependenciesMatches[0].trim()}\n${codeToAddDependencies}`
      );
    } else {
      vscode.window.showErrorMessage(
        "Failed to locate the dependencies block in build.gradle."
      );
    }

    // Write the updated content to the file
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

function updateAndroidManifest() {
  const manifestPath = getFilePath("android/app/src/main/AndroidManifest.xml");

  const permissionsBlock = `
      <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
      <uses-permission android:name="android.permission.VIBRATE" />
      <uses-permission android:name="android.permission.USE_FULL_SCREEN_INTENT" />
      <uses-permission android:name="android.permission.USE_EXACT_ALARM" />
      <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
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
      const updatedContent =
        currentContent.slice(0, insertionIndex) +
        "    " +
        showWhenLockedAndTurnScreenOn +
        "\n" +
        additionalBlock +
        "\n  " +
        currentContent.slice(insertionIndex);

      // Add permissions block below </application>
      const updatedContentWithPermissions = updatedContent.replace(
        /<\/application>/,
        permissionsBlock + "\n  </application>"
      );

      // Write the updated content back to the file
      fs.writeFileSync(manifestPath, updatedContentWithPermissions);
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
