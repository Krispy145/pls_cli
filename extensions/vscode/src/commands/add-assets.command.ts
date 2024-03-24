import * as fs from "fs";
import * as path from "path";
import { Uri, window } from "vscode";
import { promisify } from "util";

const readdir = promisify(fs.readdir);
const stat = promisify(fs.stat);
const copyFile = promisify(fs.copyFile);

// Main function for the VSCode command
export const newAssets = async (args: Uri) => {
  window.showInformationMessage("Hello from newAssets!");
  try {
    // Prompt the user to select the assets folder
    const assetsFolder = await window.showOpenDialog({
      canSelectFolders: true,
      canSelectFiles: false,
      openLabel: "Select Assets Folder",
    });

    window.showInformationMessage(`Selected folder: ${assetsFolder?.length}`);
    if (assetsFolder && assetsFolder.length > 0) {
      const assetsPath = assetsFolder[0].fsPath;

      // Get platform-specific directories
      const iosDir = path.join(assetsPath, "ios/Runner");
      const androidDir = path.join(assetsPath, "android/app/src");
      const macOSDir = path.join(assetsPath, "macos/Runner");
      const webDir = path.join(assetsPath, "web");
      //   const linuxDir = path.join(assetsPath, "linux");

      // Handle assets for each platform
      await handleAssets(iosDir, assetsPath);
      await handleAssets(androidDir, assetsPath);
      await handleAssets(macOSDir, assetsPath);
      await handleAssets(webDir, assetsPath);
      //   await handleAssets(linuxDir, assetsPath);
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
      // File exists, replace it
      await copyFile(src, dest);
      console.log(`Replaced file: ${dest}`);
    }
  } catch (error: any) {
    if (error.code === "ENOENT") {
      // File doesn't exist in the destination, add it
      await copyFile(src, dest);
      console.log(`Added file: ${dest}`);
    } else {
      console.error(`Error adding or updating file: ${error.message}`);
    }
  }
};

const scanAndCopyAssets = async (srcDir: string, destDir: string) => {
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
        // Recursively scan subdirectories
        await scanAndCopyAssets(srcPath, destPath);
      } else {
        // Add or update the file in the destination
        await addOrUpdateFile(srcPath, destPath);
      }
    }
  } catch (error: any) {
    console.error(`Error scanning directory: ${error.message}`);
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
  const scanAndCopyPlatformAssets = async (srcDir: string, destDir: string) => {
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
          // Recursively scan subdirectories
          await scanAndCopyPlatformAssets(srcPath, destDir);
        } else {
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
