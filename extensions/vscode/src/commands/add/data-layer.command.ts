import { Uri, window } from "vscode";
import { runCommandInWorkspaceFolder } from "../../utils/build_runner";
import { findProjectName } from "../../utils/get-target-directory";
import { promptForDataSourceTypes } from "../../utils/data_source_types";

export const addDataLayer = async (args: Uri) => {
  try {
    const name = await window.showInputBox({
      prompt: "Name of the Data layer",
      placeHolder: "Data layer name",
      ignoreFocusOut: true,
    });
    var types = await promptForDataSourceTypes();

    const pickedDataSourceType = types?.map((item) => `--${item}`).join(" ");

    if (name) {
      var projectNames = findProjectName(args);
      var projectName = projectNames[0] + projectNames[1];
      const commandNewDataLayer = `oasis add data_layer --name=${name} --project=${projectName} --runner ${pickedDataSourceType}`;
      await runCommandInWorkspaceFolder(args, commandNewDataLayer, {
        folderPath: "lib",
      });
    }
  } catch (error) {
    window.showErrorMessage(`Error: ${error}`);
  }
};
