import { exec } from "child_process";
import { Uri, window } from "vscode";
import { getTargetDirectory } from "../utils/get-target-directory";

export const addComponent = async (args: Uri) => {
  const name = await window.showInputBox({
    prompt: "Name of the component",
    placeHolder: "Component name",
  });
  const targetDir = await getTargetDirectory(args);

  if (name) {
    let child = exec(
      `render add component --name ${name} --path ${targetDir}`
    );
    child.stderr?.on("data", (data) => window.showErrorMessage(data));
  }
};
