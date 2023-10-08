import { window, workspace } from "vscode";
import { exec } from "child_process";

export const buildRunner = async (commandName: string) => {
  // Define the build runner command
  const buildRunnerCommand =
    "flutter pub run build_runner build --delete-conflicting-outputs";
  const workspaceFolder = workspace.workspaceFolders?.[0];
  if (workspaceFolder) {
    const buildRunnerResult = await runCommandInWorkspaceFolder(
      workspaceFolder.uri.fsPath,
      buildRunnerCommand
    );
    if (buildRunnerResult.error) {
      window.showErrorMessage(`Error running build runner: ${buildRunnerResult.error}`);
    } else {
      window.showInformationMessage(`${commandName} created successfully and build runner completed.`);
    }
  } else {
    window.showWarningMessage("No workspace folder found.");
  }
};

// Function to run a command in a specified workspace folder
const runCommandInWorkspaceFolder = async (
  folderPath: string,
  command: string
): Promise<{ error?: string }> => {
  return new Promise((resolve) => {
    exec(command, { cwd: folderPath }, (error, stdout, stderr) => {
      if (error) {
        resolve({ error: error.message });
      } else {
        resolve({});
      }
    });
  });
};
