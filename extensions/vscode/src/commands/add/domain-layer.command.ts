import { Uri, window } from "vscode";
import { runCommandInWorkspaceFolder } from "../../utils/build_runner";

export const addDomainLayer = async (args: Uri) => {
  try {
    const name = await window.showInputBox({
      prompt: "Name of the Domain layer",
      placeHolder: "Domain layer name",
    });

    if (name) {
      const commandNewDomainLayer = `oasis add domain_layer --name=${name} --runner`;
      await runCommandInWorkspaceFolder(args, commandNewDomainLayer, {
        folderPath: "lib",
      });
    }
  } catch (error) {
    window.showErrorMessage(`Error: ${error}`);
  }
};
