import { exec } from "child_process";
import { Uri, window } from "vscode";
import { getTargetDirectory } from "../utils/get-target-directory";

export async function addPage(args: Uri) {
  try {
    const name = await window.showInputBox({
      prompt: "Name of the Page",
      placeHolder: "Page name",
    });

    if (!name) {
      return;
    }

    let targetDirectory = await getTargetDirectory(args);

    const command = `rn add page --name ${name} -p ${targetDirectory}`;
    const child = exec(command, { cwd: targetDirectory });
    child.stderr?.on("data", (data) => window.showErrorMessage(data));
    child.stdout?.on("close", () =>
      window.showInformationMessage(
        "Coppied the route to your clipboard.\nAdd it to the router config in the desired location",
      ),
    );
    return;
  } catch (e) {
    window.showErrorMessage(`${e}`);
  }
}
