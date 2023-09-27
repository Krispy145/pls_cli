import { exec } from "child_process";
import { Uri, window } from "vscode";
import { getTargetDirectory } from "../utils/get-target-directory";

export const addModel = async (args: Uri) => {
  const name = await window.showInputBox({
    prompt: "Name of the model",
    placeHolder: "Model name",
  });
  const isSerializable = await window.showQuickPick(["Yes", "No"], {
    canPickMany: false,
    title: "Is the model serializable?",
  });

  if (name) {
    let command = `render add model --name ${name} -p ${await getTargetDirectory(
      args
    )} ${isSerializable === "Yes" && "--serializable"}`;

    let child = exec(command);
    child.stderr?.on("data", (data) => window.showErrorMessage(data));
  }
};
