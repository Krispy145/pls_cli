import { Uri, window } from "vscode";
import { exec } from "child_process";
import { getTargetDirectory } from "../utils/get-target-directory";

export const newFeature = async (args: Uri) => {
  try {
    const name = await window.showInputBox({
      prompt: "Name of the feature",
      placeHolder: "Feature name",
    });
    const targetDir = await getTargetDirectory(args);

    if (name) {
      const commandNewFeature = `rn add feature --name ${name} --path ${targetDir}`;
      exec(commandNewFeature, (error, stdout, stderr) => {
        if (error) {
          // Handle the error by displaying an error message to the user
          window.showErrorMessage(`Error: ${error.message}`);
        } else {
          // Process the command's output (if needed)
        }
      });
    }
  } catch (error) {
    // Handle exceptions (e.g., if showInputBox or getTargetDirectory fails)
    window.showErrorMessage(`Error: ${error}`);
  }
};
