import {Uri, window} from "vscode";
import {runCommandInWorkspaceFolder} from "../../utils/build_runner";
import {findProjectName} from "../../utils/get-target-directory";

export const addDomainLayer = async (args: Uri) => {
  try {
    const name = await window.showInputBox({
      prompt: "Name of the Domain layer",
      placeHolder: "Domain layer name",
      ignoreFocusOut: true,
    });

    if (name) {
      var projectNames = findProjectName(args);
      var projectName = projectNames[0] + projectNames[1];
      const commandNewDomainLayer = `pls add domain_layer --name=${name} --project=${projectName} --runner`;
      await runCommandInWorkspaceFolder(args, commandNewDomainLayer, {
        folderPath: "lib",
      });
    }
  } catch (error) {
    window.showErrorMessage(`Error: ${error}`);
  }
};
