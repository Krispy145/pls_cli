import { Uri, window, workspace } from "vscode";
import { exec } from "child_process";
import { getTargetDirectory } from "../utils/get-target-directory";
import * as path from "path";
import { buildRunner } from "../utils/build_runner";
// import { createLoggerFeatureString } from "../utils/add_to_files";

export const newFeature = async (args: Uri) => {
  try {
    const name = await window.showInputBox({
      prompt: "Name of the feature",
      placeHolder: "Feature name",
    });
    const targetDir = await getTargetDirectory(args);

    if (name) {
      //  // Create a logger feature string using the provided name
      //  const loggerFeatureString = createLoggerFeatureString(name);

      //  // Get the path to the logger feature file
      //  const loggerFeatureFilePath = getLoggerFeatureFilePath();

      //  // Replace the content within the logger feature file
      //  writeFileWithReplacement(loggerFeatureFilePath, loggerFeatureString);
      const commandNewFeature = `rn add feature --name ${name} --path ${targetDir}`;
      exec(commandNewFeature, async (error, stdout, stderr) => {
        if (error) {
          // Handle the error by displaying an error message to the user
          window.showErrorMessage(`Error creating feature: ${error.message}`);
        }
      });

      // Continue with running the build runner command
      await buildRunner("Feature and Logger");
    }
  } catch (error) {
    window.showErrorMessage(`Error: ${error}`);
  }
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
