import * as fs from "fs";
import * as path from "path";
import { Uri, window, workspace } from "vscode";
import { promisify } from "util";

const readdir = promisify(fs.readdir);
const stat = promisify(fs.stat);
const copyFile = promisify(fs.copyFile);

// Main function for the VSCode command
export const newAssets = async (args: Uri) => {
  window.showInformationMessage("Adding assets: 1");
  try {
    // Prompt the user to select the assets folder
    const assetsFolder = await window.showOpenDialog({
      canSelectFolders: true,
      canSelectFiles: false,
      openLabel: "Select Assets Folder",
    });

    if (assetsFolder && assetsFolder.length > 0) {
      const assetsPath = assetsFolder[0].fsPath;
      window.showInformationMessage(`Selected assets folder: ${assetsPath}`);
      const workspaceFolder = workspace.workspaceFolders?.[0];

      if (!workspaceFolder) {
        window.showErrorMessage("No workspace folder found.");
        return { error: "No workspace folder found." };
      }

      const rootProjectPath = workspaceFolder.uri.fsPath;

      // Get platform-specific directories
      const iosDir = path.join(rootProjectPath, "ios/Runner");
      const androidDir = path.join(rootProjectPath, "android/app/src");
      const macOSDir = path.join(rootProjectPath, "macos/Runner");
      const webDir = path.join(rootProjectPath, "web");
      //   const linuxDir = path.join(assetsPath, "linux");

      // Get Asset Platform Directories
      const iosAssetsDir = path.join(assetsPath, "ios");
      const androidAssetsDir = path.join(assetsPath, "android");
      const macOSAssetsDir = path.join(assetsPath, "macos");
      const webAssetsDir = path.join(assetsPath, "web");
      // const linuxAssetsDir = path.join(assetsPath, "linux");

      // Handle assets for each platform
      if (fs.existsSync(iosAssetsDir)) {
        await handleAssets(iosDir, iosAssetsDir);
      }
      if (fs.existsSync(androidAssetsDir)) {
        await handleAssets(androidDir, androidAssetsDir);
      }
      if (fs.existsSync(macOSAssetsDir)) {
        await handleAssets(macOSDir, macOSAssetsDir);
      }
      if (fs.existsSync(webAssetsDir)) {
        await handleAssets(webDir, webAssetsDir);
      }
      //   if (fs.existsSync(linuxAssetsDir)) {
      //       await handleAssets(linuxDir, linuxAssetsDir);
      //   }
    } else {
      window.showErrorMessage("No assets folder selected.");
    }
  } catch (error: any) {
    window.showErrorMessage(`Error: ${error.message}`);
  }
};

const addOrUpdateFile = async (src: string, dest: string) => {
  try {
    // Check if the file already exists in the destination
    const destStats = await stat(dest);
    if (destStats.isFile()) {
      window.showInformationMessage("File exists");
      // File exists, replace it
      await copyFile(src, dest);
      console.log(`Replaced file: ${dest}`);
    }
  } catch (error: any) {
    if (error.code === "ENOENT") {
      window.showInformationMessage("File does not exist");
      // File doesn't exist in the destination, add it
      await copyFile(src, dest);
      console.log(`Added file: ${dest}`);
    } else {
      console.error(`Error adding or updating file: ${error.message}`);
    }
  }
};

// // Function to separate assets into platform directories
// const separateAssets = async (assetsPath: string) => {
//   // Create platform directories if they don't exist
//   const platformDirs = ["ios", "android", "macos", "linux", "web"];
//   for (const platformDir of platformDirs) {
//     const dirPath = path.join(assetsPath, platformDir);
//     if (!fs.existsSync(dirPath)) {
//       fs.mkdirSync(dirPath);
//     }
//   }

//   // Move assets to corresponding platform directories
//   // You need to implement the logic to move files here
// };
const handleAssets = async (platformDir: string, assetsPath: string) => {
  window.showInformationMessage(`Copying assets to ${platformDir}`);
  const scanAndCopyPlatformAssets = async (srcDir: string, destDir: string) => {
    window.showInformationMessage(`Copying assets to ${destDir}`);
    try {
      // Read contents of the source directory
      const files = await readdir(srcDir);

      // Iterate through each file in the directory
      for (const file of files) {
        const srcPath = path.join(srcDir, file);
        const destPath = path.join(destDir, file);

        // Check if the current item is a directory
        const stats = await stat(srcPath);
        if (stats.isDirectory()) {
          window.showInformationMessage("Directory found");
          // Recursively scan subdirectories
          await scanAndCopyPlatformAssets(srcPath, destPath);
        } else {
          window.showInformationMessage("File found");
          // Add or update the file in the destination
          await addOrUpdateFile(srcPath, destPath);
        }
      }
    } catch (error: any) {
      console.error(`Error scanning iOS directory: ${error.message}`);
    }
  };

  await scanAndCopyPlatformAssets(assetsPath, platformDir);
};

// open file explorer to select assets folder
// separate assets folder into these directories:
// - assets/ios
// - assets/android
// - assets/web
// - assets/macos
// - assets/linux
// make separate functions for each directory
// call each function with the path to the directory
// for each directory inside the platform directory,
// search for files already there (there are nested directories with files),
// and if in the uploaded directory, replace,
// otherwise add (Do not remove files that are there but do not have a replacement).
// if a directory exists in the uploaded directory but not in the platform directory, add it.
