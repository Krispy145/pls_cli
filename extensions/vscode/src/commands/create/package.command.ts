import { Uri, window } from "vscode";

export const createPackage = async (args: Uri) => {
  const folderUri = await window.showOpenDialog({
    canSelectFiles: false,
    canSelectFolders: true,
    canSelectMany: false,
    openLabel: "Select Directory",
  });

  if (!folderUri || folderUri.length === 0) {
    window.showErrorMessage("No directory selected.");
    return;
  }

  const appDirectory = folderUri[0].fsPath;

  const terminal = window.createTerminal("Create New Package");
  const cmd = `oasis create package`;

  // Change to the packageDirectory and run the command
  terminal.sendText(`cd "${appDirectory}"`);
  terminal.sendText(cmd);
  terminal.show();
};
