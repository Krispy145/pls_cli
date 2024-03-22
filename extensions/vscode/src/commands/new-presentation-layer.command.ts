import { Uri, window } from "vscode";
import { runCommandInWorkspaceFolder } from "../utils/build_runner";

export const newPresentationLayer = async (args: Uri) => {
  try {
    const name = await window.showInputBox({
      prompt: "Name of the Presentation layer",
      placeHolder: "Presentation layer name",
    });

    if (name) {
      const commandNewPresentationLayer = `up add presentation_layer --name ${name}`;
      await runCommandInWorkspaceFolder(commandNewPresentationLayer, {
        folderPath: "lib/presentation",
      });
    }
  } catch (error) {
    window.showErrorMessage(`Error: ${error}`);
  }
};
