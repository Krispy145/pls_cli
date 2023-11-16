import { window, workspace, ProgressLocation } from "vscode";
import { exec } from "child_process";

export const formatFiles = async () => {
  const workspaceFolder = workspace.workspaceFolders?.[0];
  if (!workspaceFolder) {
    window.showWarningMessage("No workspace folder found.");
    return;
  }

  await runCommandInWorkspaceFolder(
    workspaceFolder.uri.fsPath,
    "dart format ."
  );
  await runCommandInWorkspaceFolder(
    workspaceFolder.uri.fsPath,
    "dart fix --apply"
  );

  window.showInformationMessage("Files cleaned.");
};

export const buildRunner = async (commandName: string) => {
  // Define the build runner command
  const buildRunnerCommand =
    "flutter pub run build_runner build --delete-conflicting-outputs";
  const workspaceFolder = workspace.workspaceFolders?.[0];
  if (!workspaceFolder) {
    window.showWarningMessage("No workspace folder found.");
    return;
  }
  await window.withProgress(
    {
      location: ProgressLocation.Notification,
      title: `Running ${commandName} and Build Runner...`,
      cancellable: false,
    },
    async () => {
      const buildRunnerResult = await runCommandInWorkspaceFolder(
        workspaceFolder.uri.fsPath,
        buildRunnerCommand
      );
      await formatFiles();
      if (buildRunnerResult.error) {
        window.showErrorMessage(
          `Error running build runner: ${buildRunnerResult.error}`
        );
      } else {
        window.showInformationMessage(
          `${commandName} created successfully and build runner completed.`
        );
      }
    }
  );
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
