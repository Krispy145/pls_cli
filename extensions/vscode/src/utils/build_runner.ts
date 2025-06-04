import {mkdirp} from "mkdirp";
import {window, ProgressLocation, Uri} from "vscode";
import {exec} from "child_process";
import {getWorkspaceFilePath} from "./get-target-directory";

export const buildScripts = [
  "flutter clean",
  "flutter pub get",
  "dart format .",
  "flutter pub run build_runner build --delete-conflicting-outputs",
];

export const formatFiles = async (args: Uri) => {
  await runCommandInWorkspaceFolder(args, "dart format .");
  await runCommandInWorkspaceFolder(args, "dart fix --apply");

  window.showInformationMessage("Files cleaned.");
};

export const buildRunner = async (args: Uri, commandName: string) => {
  // Define the build runner command
  const buildRunnerCommand =
    "flutter pub run build_runner build --delete-conflicting-outputs";
  const isLib = args.path.includes("lib");

  await window.withProgress(
    {
      location: ProgressLocation.Notification,
      title: `Running ${commandName} and Build Runner...`,
      cancellable: false,
    },
    async () => {
      const buildRunnerResult = await runCommandInWorkspaceFolder(
        args,
        buildRunnerCommand,
        {
          folderPath: isLib ? undefined : "lib",
        }
      );
      await formatFiles(args);
      if (buildRunnerResult.error) {
        window.showErrorMessage(
          `Error running build runner: ${buildRunnerResult.error}`
        );
      } else {
        window.showInformationMessage(
          `${commandName} created and build runner completed.`
        );
      }
    }
  );
};

export const runCommandInWorkspaceFolder = async (
  args: Uri,
  command: string,
  {folderPath}: {folderPath?: string} = {}
): Promise<{error?: string}> => {
  const fullPath = getWorkspaceFilePath(args, folderPath ?? "");

  // Create directories if folderPath is specified
  if (folderPath) {
    try {
      mkdirp.sync(fullPath);
    } catch (mkdirpError: any) {
      window.showErrorMessage(
        `Error creating directories: ${mkdirpError.message}`
      );
      return {error: mkdirpError.message};
    }
  }

  return new Promise((resolve) => {
    window.showInformationMessage(`Running command: ${command}`);

    const childProcess = exec(
      command,
      {cwd: fullPath},
      (error, stdout, stderr) => {
        if (error) {
          window.showErrorMessage(`Error executing command: ${error.message}`);
          window.showErrorMessage(`Command output: ${stderr}`);
          resolve({error: error.message});
        } else {
          window.showInformationMessage(`Command output: ${stdout}`);
          window.showInformationMessage(`Command executed successfully`);
          resolve({});
        }
      }
    );

    // Log errors, if any, during the execution
    childProcess.stderr?.on("data", (data) => {
      window.showErrorMessage(`Error during execution: ${data}`);
    });
  });
};

export const runCommandsFromPath = async (
  fullPath: string,
  commands: string[]
): Promise<{error?: string}> => {
  // Iterate over the commands and execute them sequentially
  for (const command of commands) {
    try {
      await runCommand(fullPath, command);
    } catch (error) {
      window.showErrorMessage(`Error: ${error}`);
    }
  }

  return {};
};

const runCommand = async (
  fullPath: string,
  command: string
): Promise<{error?: string}> => {
  return new Promise((resolve) => {
    window.showInformationMessage(`Running command: ${command}`);

    const childProcess = exec(
      command,
      {cwd: fullPath},
      (error, stdout, stderr) => {
        if (error) {
          window.showErrorMessage(`Error executing command: ${error.message}`);
          window.showErrorMessage(`Command output: ${stderr}`);
          resolve({error: error.message});
        } else {
          window.showInformationMessage(`Command output: ${stdout}`);
          window.showInformationMessage(`Command executed successfully`);
          resolve({});
        }
      }
    );

    // Log errors, if any, during the execution
    childProcess.stderr?.on("data", (data) => {
      window.showErrorMessage(`Error during execution: ${data}`);
    });
  });
};
