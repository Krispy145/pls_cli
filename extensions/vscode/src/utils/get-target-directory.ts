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

// Function to get the required file path in the workspace
export const getWorkspaceFilePath = (
  uri: Uri,
  relativePath: string
): string => {
  var currentWorkspace = workspace.workspaceFolders?.find((workspace) =>
    uri.fsPath.startsWith(workspace.uri.fsPath)
  );
  if (currentWorkspace) {
    return path.join(currentWorkspace.uri.fsPath, relativePath);
  } else {
    window.showErrorMessage("No workspace folder found.");
    throw new Error("No workspace folder found.");
  }
};
