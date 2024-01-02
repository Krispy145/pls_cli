import { exec } from "child_process";
import * as vscode from "vscode";

export function addFlutterPackageFromPath(
  packageName: string,
  packagePath: string
): void {
  if (packagePath) {
    const cmd = `flutter pub add ${packageName} --path=${packagePath}`;

    exec(cmd, {}, (error, stdout, stderr) => {
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
      vscode.window.showInformationMessage(
        `${packageName} package added to dependencies`
      );
    });
  } else {
    vscode.window.showErrorMessage(
      "Invalid input. Provide a valid packagePath."
    );
  }
}

export function addFlutterPackageFromGit(
  packageName: string,
  gitUrl: string,
  gitRef: string,
  targetDir: string | undefined
): void {
  if (gitUrl && gitRef) {
    const cmd = `flutter pub add ${packageName} --git=${gitUrl} --ref=${gitRef}`;

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
      vscode.window.showInformationMessage(
        `${packageName} package added to dependencies`
      );
    });
  } else {
    vscode.window.showErrorMessage("Invalid input. Provide gitUrl and gitRef.");
  }
}
