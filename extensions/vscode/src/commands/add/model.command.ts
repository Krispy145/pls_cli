import {exec} from "child_process";
import {Uri, window} from "vscode";
import {getTargetDirectory} from "../../utils/get-target-directory";
import {buildRunner} from "../../utils/build_runner";

export const addModel = async (args: Uri) => {
  const name = await window.showInputBox({
    prompt: "Name of the model",
    placeHolder: "Model name",
    ignoreFocusOut: true,
  });
  var targetDir = await getTargetDirectory(args);

  if (name && targetDir) {
    // Check if the targetDir ends with "models"
    if (!targetDir.endsWith("models")) {
      targetDir += "/models";
    }

    let child = exec(
      `pls add model --name=${name} --path=${targetDir} --runner`
    );
    child.stderr?.on("data", (data) => window.showErrorMessage(data));

    await buildRunner(args, "Model");
  }
};
