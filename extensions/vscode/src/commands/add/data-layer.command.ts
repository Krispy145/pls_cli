import { Uri, window } from "vscode";
import { runCommandInWorkspaceFolder } from "../../utils/build_runner";
import { findProjectName } from "../../utils/get-target-directory";

export const addDataLayer = async (args: Uri) => {
  try {
    const name = await window.showInputBox({
      prompt: "Name of the Data layer",
      placeHolder: "Data layer name",
      ignoreFocusOut: true,
    });

    if (name) {
      var projectName = findProjectName(args);
      const commandNewDataLayer = `oasis add data_layer --name=${name} --project=${projectName} --runner`;
      await runCommandInWorkspaceFolder(args, commandNewDataLayer, {
        folderPath: "lib",
      });
    }
  } catch (error) {
    window.showErrorMessage(`Error: ${error}`);
  }
};
