import { Uri, window, workspace } from "vscode";
import { exec } from "child_process";
import { getTargetDirectory } from "../utils/get-target-directory";
import * as path from "path";


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
          // Create a logger feature string using the provided name
          const loggerFeatureString = createLoggerFeatureString(name);

          // Get the path to the logger feature file
          const loggerFeatureFilePath = getLoggerFeatureFilePath();

          // Replace the content within the logger feature file
          writeFileWithReplacement(loggerFeatureFilePath, loggerFeatureString);
        }
      });

      // Continue with running the build runner command
      const buildRunnerCommand =
        "flutter pub run build_runner build --delete-conflicting-outputs";
      const workspaceFolder = workspace.workspaceFolders?.[0];
      if (workspaceFolder) {
        const buildRunnerResult = await runCommandInWorkspaceFolder(
          workspaceFolder.uri.fsPath,
          buildRunnerCommand
        );
        if (buildRunnerResult.error) {
          window.showErrorMessage(
            `Error running build runner: ${buildRunnerResult.error}`
          );
        } else {
          window.showInformationMessage(
            "Feature created successfully and build runner completed."
          );
        }
      } else {
        window.showWarningMessage("No workspace folder found.");
      }
    }
  } catch (error) {
    // Handle exceptions (e.g., if showInputBox or getTargetDirectory fails)
    window.showErrorMessage(`Error: ${error}`);
  }
};

// Function to create the logger feature string
const createLoggerFeatureString = (name: string): string => {
  const camelCaseName = toCamelCase(name);
  const constantCaseName = toConstantCase(name);

  return `  static final LoggerFeature ${camelCaseName} = LoggerFeature("${constantCaseName}", true);\n///LOGGER FEATURE END`;
};

// Function to convert a string to camelCase
const toCamelCase = (str: string): string => {
  return str.replace(/[-_]+(.)?/g, (_, c) => (c ? c.toUpperCase() : ""));
};

// Function to convert a string to CONSTANT_CASE
const toConstantCase = (str: string): string => {
  return str.replace(/[-\s]+/g, "_").toUpperCase();
};

// Function to get the path to the logger feature file
const getLoggerFeatureFilePath = (): string => {
  const currentWorkspace = workspace.workspaceFolders?.[0];
  if (currentWorkspace) {
    return path.join(
      currentWorkspace.uri.fsPath,
      "lib",
      "utils",
      "logger_features.dart"
    );
  } else {
    throw new Error("No workspace folder found.");
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

// Function to write content to a file, replacing a specific text
const writeFileWithReplacement = (
  filePath: string,
  replacementText: string
) => {
  try {
    const fs = require("fs");
    const fileContent = fs.readFileSync(filePath, "utf-8");
    const updatedContent = fileContent.replace(
      /\/\/\/LOGGER FEATURE END/g,
      replacementText
    );
    fs.writeFileSync(filePath, updatedContent, "utf-8");
  } catch (error) {
    throw new Error(`Error writing to file: ${error}`);
  }
};


