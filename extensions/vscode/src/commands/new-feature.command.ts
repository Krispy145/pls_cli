import { Uri, window } from "vscode";
import { runCommandInWorkspaceFolder } from "../utils/build_runner";

export const newFeature = async (args: Uri) => {
  try {
    const name = await window.showInputBox({
      prompt: "Name of the feature",
      placeHolder: "Feature name",
    });

    if (name) {
      const commandNewFeature = `rn add feature --name ${name}`;
      await runCommandInWorkspaceFolder(commandNewFeature, {
        folderPath: "lib",
      });
    }
  } catch (error) {
    window.showErrorMessage(`Error: ${error}`);
  }
};
