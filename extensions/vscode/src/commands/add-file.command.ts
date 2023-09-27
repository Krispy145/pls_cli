import { exec } from "child_process";
import { Uri, window } from "vscode";

export const addFile = async (args: Uri) => {
  const name = await window.showInputBox({
    prompt: "Name of the file",
    placeHolder: "File name",
  });
  if (!name) {
    return;
  }
  const command = `render add file -p ${args.fsPath}/${name}.dart`;

  let child = exec(command);
  child.stderr?.on("data", (data) => window.showErrorMessage(data));
};
