import { Uri, window } from "vscode";
import { runCommandInWorkspaceFolder } from "../utils/build_runner";

export const newAuth = async (args: Uri) => {
  try {
    const commandNewAuth = `rn add auth`;
    await runCommandInWorkspaceFolder(commandNewAuth, {
      folderPath: "lib",
    });
  } catch (error) {
    window.showErrorMessage(`Error: ${error}`);
  }
};
