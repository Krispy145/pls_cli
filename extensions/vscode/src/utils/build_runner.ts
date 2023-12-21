import { window, workspace, ProgressLocation } from "vscode";
import { exec } from "child_process";

export const formatFiles = async () => {
  await runCommandInWorkspaceFolder("dart format .");
  await runCommandInWorkspaceFolder("dart fix --apply");

  window.showInformationMessage("Files cleaned.");
};

export const buildRunner = async (commandName: string) => {
  // Define the build runner command
  const buildRunnerCommand =
    "flutter pub run build_runner build --delete-conflicting-outputs";

  await window.withProgress(
    {
      location: ProgressLocation.Notification,
      title: `Running ${commandName} and Build Runner...`,
      cancellable: false,
    },
    async () => {
      const buildRunnerResult = await runCommandInWorkspaceFolder(
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

export const runCommandInWorkspaceFolder = async (
  command: string,
  { folderPath }: { folderPath?: string } = {}
): Promise<{ error?: string }> => {
  const workspaceFolder = workspace.workspaceFolders?.[0];

  if (!workspaceFolder) {
    window.showErrorMessage("No workspace folder found.");
    return { error: "No workspace folder found." };
  }

  const rootProjectPath = workspaceFolder.uri.fsPath;
  const fullPath = folderPath
    ? `${rootProjectPath}/${folderPath}`
    : rootProjectPath;

  return new Promise((resolve) => {
    window.showInformationMessage(`Running command in ${fullPath}: ${command}`);

    const childProcess = exec(
      command,
      { cwd: fullPath },
      (error, stdout, stderr) => {
        if (error) {
          window.showErrorMessage(`Error executing command: ${error.message}`);
          window.showErrorMessage(`Command output: ${stderr}`);
          resolve({ error: error.message });
        } else {
          window.showInformationMessage(`Command output: ${stdout}`);
          window.showInformationMessage(
            `Command executed successfully in ${fullPath}`
          );
          resolve({});
        }
      }
    );

    // Log the progress of the command
    childProcess.stdout?.on("data", (data) => {
      window.showInformationMessage(`Progress: ${data}`);
    });

    // Log errors, if any, during the execution
    childProcess.stderr?.on("data", (data) => {
      window.showErrorMessage(`Error during execution: ${data}`);
    });
  });
};
