import {
  InputBoxOptions,
  OpenDialogOptions,
  Uri,
  window,
  workspace,
} from "vscode";
import * as _ from "lodash";
import { lstatSync } from "fs";
import * as path from "path";

export const getTargetDirectory = async (
  uri: Uri
): Promise<string | undefined> => {
  let targetDirectory;
  if (_.isNil(_.get(uri, "fsPath")) || !lstatSync(uri.fsPath).isDirectory()) {
    targetDirectory = await promptForTargetDirectory();
    if (_.isNil(targetDirectory)) {
      window.showErrorMessage("Please select a valid directory");
      return;
    }
  } else {
    targetDirectory = uri.fsPath;
  }
  return targetDirectory;
};

async function promptForTargetDirectory(): Promise<string | undefined> {
  const options: OpenDialogOptions = {
    canSelectMany: false,
    openLabel: "Select a folder to create the bloc in",
    canSelectFolders: true,
  };

  return window.showOpenDialog(options).then((uri) => {
    if (_.isNil(uri) || _.isEmpty(uri)) {
      return undefined;
    }
    return uri[0].fsPath;
  });
}

// Function to find the name of the Project/Ecosystem
export const findProjectName = (uri: Uri): string[] => {
  const currentWorkspace = workspace.getWorkspaceFolder(uri);
  if (currentWorkspace) {
    var baseName = path.basename(currentWorkspace.uri.fsPath);
    if (baseName === "lib") {
      var parentPath = path.dirname(currentWorkspace.uri.fsPath);
      if (parentPath.includes("_app")) {
        return [
          path.basename(parentPath.substring(0, parentPath.length - 4)),
          "_app",
        ];
      }
      if (parentPath.includes("_dashboard")) {
        return [
          path.basename(parentPath.substring(0, parentPath.length - 10)),
          "_dashboard",
        ];
      }
      if (parentPath.includes("_package")) {
        return [
          path.basename(parentPath.substring(0, parentPath.length - 8)),
          "_package",
        ];
      } else {
        return [path.basename(parentPath)];
      }
    } else {
      if (baseName.includes("_app")) {
        return [baseName.substring(0, baseName.length - 4), "_app"];
      }
      if (baseName.includes("_dashboard")) {
        return [baseName.substring(0, baseName.length - 10), "_dashboard"];
      }
      if (baseName.includes("_package")) {
        return [baseName.substring(0, baseName.length - 8), "_package"];
      }
    }
    window.showInformationMessage(`No changes made: ${baseName}`);
    return [baseName];
  } else {
    window.showErrorMessage("No workspace folder found.");
    throw new Error("No workspace folder found.");
  }
};

// Function to get the required file path in the workspace
export const getWorkspaceFilePath = (
  uri: Uri,
  relativePath: string
): string => {
  const currentWorkspace = workspace.getWorkspaceFolder(uri);
  if (currentWorkspace) {
    return path.join(currentWorkspace.uri.fsPath, relativePath);
  } else {
    window.showErrorMessage("No workspace folder found.");
    throw new Error("No workspace folder found.");
  }
};
