import { Uri, window, workspace } from "vscode";

export const createApp = async (args: Uri) => {
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

  const appName = await window.showInputBox({
    prompt: "Enter the name for your new app",
    placeHolder: "digital_oasis_app",
    ignoreFocusOut: true,
  });

  if (!appName) {
    window.showErrorMessage("App name not provided. Aborting.");
    return;
  }

  const terminal = window.createTerminal("Create New App");
  const cmd = `oasis create app ${appName}`;

  // Change to the appDirectory and run the command
  terminal.sendText(`cd "${appDirectory}"`);
  terminal.sendText(cmd);
  terminal.show();
};
