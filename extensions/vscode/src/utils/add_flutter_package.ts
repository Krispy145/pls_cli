import { exec } from "child_process";
import * as vscode from "vscode";

export function addFlutterPackage(packageName: string, packagePath: string, targetDir: string | undefined): void {
  const cmd = `flutter pub add ${packageName} --path=${packagePath}`;

  exec(cmd, { cwd: targetDir }, (error, stdout, stderr) => {
    if (error) {
      console.error(`Error: ${error.message}`);
      vscode.window.showErrorMessage(`Error: ${error.message}`);
      return;
    }
    if (stderr) {
      console.error(`stderr: ${stderr}`);
      vscode.window.showErrorMessage(`stderr: ${stderr}`);
      return;
    }
    console.log(`stdout: ${stdout}`);
    vscode.window.showInformationMessage(`${packageName} package added to dependencies`);
  });
}

// Example usage:
const targetDir = "/path/to/your/flutter/project";
const admobPath = "/Users/davidkisbey-green/Desktop/Digital_Oasis/admob/";
const notificationsPath = "/Users/davidkisbey-green/Desktop/Digital_Oasis/notifications/";

addFlutterPackage("admob", admobPath, targetDir);
addFlutterPackage("notifications", notificationsPath, targetDir);
