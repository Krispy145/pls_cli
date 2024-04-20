import { Uri, window } from "vscode";
import { runCommandInWorkspaceFolder } from "../../utils/build_runner";

export const addDataLayer = async (args: Uri) => {
  try {
    const name = await window.showInputBox({
      prompt: "Name of the Data layer",
      placeHolder: "Data layer name",
    });

    if (name) {
      const commandNewDataLayer = `oasis add data_layer --name=${name} --runner`;
      await runCommandInWorkspaceFolder(args, commandNewDataLayer, {
        folderPath: "lib",
      });
    }
  } catch (error) {
    window.showErrorMessage(`Error: ${error}`);
  }
};
