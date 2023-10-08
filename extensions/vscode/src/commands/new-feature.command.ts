import { Uri, window, workspace } from "vscode";
import { exec } from "child_process";
import { getTargetDirectory } from "../utils/get-target-directory";

export const newFeature = async (args: Uri) => {
  try {
    const name = await window.showInputBox({
      prompt: "Name of the feature",
      placeHolder: "Feature name",
    });
    const targetDir = await getTargetDirectory(args);

    if (name) {
      const commandNewFeature = `rn add feature --name ${name} --path ${targetDir}`;
      exec(commandNewFeature, async (error, stdout, stderr) => {
        if (error) {
          // Handle the error by displaying an error message to the user
          window.showErrorMessage(`Error creating feature: ${error.message}`);
        } else {
          // Process the command's output (if needed)
          const commandNewLoggerFeature = `rn add logger --name ${name}`;
          exec(commandNewLoggerFeature, async (loggerError, loggerStdout, loggerStderr) => {
            if (loggerError) {
              // Handle the error by displaying an error message to the user
              window.showErrorMessage(`Error creating logger feature: ${loggerError.message}`);
            } else {
              // Run the build runner command
              const buildRunnerCommand = "flutter pub run build_runner build --delete-conflicting-outputs";
              const workspaceFolder = workspace.workspaceFolders?.[0];
              if (workspaceFolder) {
                const buildRunnerResult = await runCommandInWorkspaceFolder(workspaceFolder.uri.fsPath, buildRunnerCommand);
                if (buildRunnerResult.error) {
                  window.showErrorMessage(`Error running build runner: ${buildRunnerResult.error}`);
                } else {
                  window.showInformationMessage("Feature created successfully and build runner completed.");
                }
              } else {
                window.showWarningMessage("No workspace folder found.");
              }
            }
          });
        }
      });
    }
  } catch (error) {
    // Handle exceptions (e.g., if showInputBox or getTargetDirectory fails)
    window.showErrorMessage(`Error: ${error}`);
  }
};

// Function to run a command in a specified workspace folder
const runCommandInWorkspaceFolder = async (folderPath: string, command: string): Promise<{ error?: string }> => {
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
