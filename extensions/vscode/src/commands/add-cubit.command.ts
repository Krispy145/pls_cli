import { exec } from "child_process";
import { QuickPickItem, Uri, window } from "vscode";
import { getTargetDirectory } from "../utils/get-target-directory";

export const addCubit = async (args: Uri) => {
  const name = await window.showInputBox({
    prompt: "Name of the cubit",
    placeHolder: "Cubit name",
  });
  const cubitType = await window.showQuickPick<QuickPickItem>(
    [
      {
        label: "Form",
        description: "A form cubit",
      },

      {
        label: "State",
        description: "A Cubit with a state class",
      },

      {
        label: "Base",
        picked: true,
        description: "A base cubit with a simple state",
      },
    ],
    {
      canPickMany: false,

      title: "Select the cubit type",
    }
  );
  let inputs: string | undefined;
  if (cubitType?.label === "Form") {
    inputs = await window.showInputBox({
      title: "Select the form's inputs",
      prompt: "Comma separated list of inputs",
    });
  }
  if (name && cubitType) {
    let child = exec(
      `render add cubit --name ${name} --path ${await getTargetDirectory(
        args
      )} ${cubitType.label === "Form" && "--form"} ${
        cubitType.label === "State" && "--hasState"
      } ${Boolean(inputs) && `--inputs "${inputs}"`}
      `
    );
    child.stderr?.on("data", (data) => window.showErrorMessage(data));
  }
};
