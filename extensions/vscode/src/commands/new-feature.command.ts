import { Uri, window } from "vscode";
import { exec } from "child_process";
import { getTargetDirectory } from "../utils/get-target-directory";

export const newFeature = async (args: Uri) => {
  const name = await window.showInputBox({
    prompt: "Name of the feature",
    placeHolder: "Feature name",
  });
  const targetDir = await getTargetDirectory(args);

  if (name) {
    const command = `render add feature --name ${name} --path ${targetDir}`;
    exec(command);
  }
};
