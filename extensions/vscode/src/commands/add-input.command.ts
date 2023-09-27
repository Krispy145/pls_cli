import { exec } from "child_process";
import { Uri, window } from "vscode";

export const addFormInput = async (args: Uri) => {
  const name = await window.showInputBox({
    prompt: "Name of the input",
    placeHolder: "Input name",
  });
  if (!name) {
    return;
  }
  const command = `render add input -p ${args.fsPath} --name ${name}`;

  let child = exec(command);
  child.stderr?.on("data", (data) => window.showErrorMessage(data));
};
