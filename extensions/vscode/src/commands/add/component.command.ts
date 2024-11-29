import {exec} from "child_process";
import {Uri, window} from "vscode";
import {getTargetDirectory} from "../../utils/get-target-directory";
import {buildRunner} from "../../utils/build_runner";

export const addComponent = async (args: Uri) => {
  const name = await window.showInputBox({
    prompt: "Name of the component",
    placeHolder: "Component name",
    ignoreFocusOut: true,
  });
  var targetDir = await getTargetDirectory(args);

  if (name && targetDir) {
    // Check if the targetDir ends with "components"
    if (!targetDir.endsWith("components")) {
      targetDir += "/components";
    }

    let child = exec(
      `yak add component --name=${name} --path=${targetDir} --runner`
    );
    child.stderr?.on("data", (data) => window.showErrorMessage(data));

    await buildRunner(args, "Component");
  }
};
