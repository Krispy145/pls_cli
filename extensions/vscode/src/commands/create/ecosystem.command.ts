import { Uri, window, workspace } from "vscode";

export const createEcosystem = async (args: Uri) => {
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

  const ecosystemDirectory = folderUri[0].fsPath;

  const terminal = window.createTerminal("Create New Ecosystem");
  const cmd = `oasis create ecosystem`;

  // Change to the ecosystemDirectory and run the command
  terminal.sendText(`cd "${ecosystemDirectory}"`);
  terminal.sendText(cmd);
  terminal.show();
};
