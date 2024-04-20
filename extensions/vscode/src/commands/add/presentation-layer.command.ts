import { Uri, window } from "vscode";
import { runCommandInWorkspaceFolder } from "../../utils/build_runner";

export const addPresentationLayer = async (args: Uri) => {
  try {
    const name = await window.showInputBox({
      prompt: "Name of the Presentation layer",
      placeHolder: "Presentation layer name",
    });

    if (name) {
      const commandNewPresentationLayer = `oasis add presentation_layer --name=${name} --runner`;
      await runCommandInWorkspaceFolder(args, commandNewPresentationLayer, {
        folderPath: "lib",
      });
    }
  } catch (error) {
    window.showErrorMessage(`Error: ${error}`);
  }
};
