import { Uri, window } from "vscode";
import { runCommandInWorkspaceFolder } from "../../utils/build_runner";

export const addFeature = async (args: Uri) => {
  try {
    const name = await window.showInputBox({
      prompt: "Name of the feature",
      placeHolder: "Feature name",
    });

    if (name) {
      const commandNewFeature = `oasis add feature --name=${name}`;
      await runCommandInWorkspaceFolder(args, commandNewFeature, {
        folderPath: "lib",
      });
    }
  } catch (error) {
    window.showErrorMessage(`Error: ${error}`);
  }
};
