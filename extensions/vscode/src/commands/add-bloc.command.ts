import { exec } from "child_process";
import { Uri, window } from "vscode";
import { getTargetDirectory } from "../utils/get-target-directory";

export const addBloc = async (args: Uri) => {
  const name = await window.showInputBox({
    prompt: "Name of the bloc",
    placeHolder: "Bloc name",
  });
  const blocType = await window.showQuickPick(["Form", "State"], {
    canPickMany: false,
    title: "Select the bloc type",
  });
  let inputs: string | undefined;
  let events: string | undefined;
  if (blocType === "Form") {
    inputs = await window.showInputBox({
      title: "Select the form's inputs",
      prompt: "Comma separated list of inputs",
    });
  } else {
    events = await window.showInputBox({
      title: "Select the bloc's events",
      prompt: "Comma separated list of events",
    });
  }

  if (name && blocType) {
    let command = `render add bloc --name ${name} -p ${await getTargetDirectory(
      args
    )} ${blocType === "Form" && "--form"} ${
      Boolean(events) && `--events "${events}"`
    } ${Boolean(inputs) && `--inputs "${inputs}"`}`;

    let child = exec(command);
    child.stderr?.on("data", (data) => window.showErrorMessage(data));
  }
};
