import {Uri, window} from "vscode";
import {runCommandInWorkspaceFolder} from "../../utils/build_runner";
import {findProjectName} from "../../utils/get-target-directory";

export const addPresentationLayer = async (args: Uri) => {
  try {
    const name = await window.showInputBox({
      prompt: "Name of the Presentation layer",
      placeHolder: "Presentation layer name",
      ignoreFocusOut: true,
    });

    if (name) {
      var projectNames = findProjectName(args);
      var projectName = projectNames[0] + projectNames[1];
      const commandNewPresentationLayer = `pls add presentation_layer --name=${name} --project=${projectName} --runner`;
      await runCommandInWorkspaceFolder(args, commandNewPresentationLayer, {
        folderPath: "lib",
      });
    }
  } catch (error) {
    window.showErrorMessage(`Error: ${error}`);
  }
};
