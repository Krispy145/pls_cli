import {Uri, window} from "vscode";
import {runCommandInWorkspaceFolder} from "../../utils/build_runner";
import {findProjectName} from "../../utils/get-target-directory";

export const addFeature = async (args: Uri) => {
  try {
    const name = await window.showInputBox({
      prompt: "Name of the feature",
      placeHolder: "Feature name",
      ignoreFocusOut: true,
    });

    if (name) {
      var projectNames = findProjectName(args);
      var projectName = projectNames[0];
      const commandNewFeature = `yak add feature --name=${name} --project=${projectName} --runner`;
      await runCommandInWorkspaceFolder(args, commandNewFeature, {
        folderPath: "lib",
      });
    }
  } catch (error) {
    window.showErrorMessage(`Error: ${error}`);
  }
};
