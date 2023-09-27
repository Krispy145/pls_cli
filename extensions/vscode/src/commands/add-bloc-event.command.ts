import { exec } from "child_process";
import { Uri, window } from "vscode";

export const addBlocEvent = async (args: Uri) => {
  const name = await window.showInputBox({
    prompt: "Name of the event",
    placeHolder: "Event name",
  });
  if (!name) {
    return;
  }
  const command = `render add event -p ${args.fsPath} --name ${name}`;

  let child = exec(command);
  child.stderr?.on("data", (data) => window.showErrorMessage(data));
};
