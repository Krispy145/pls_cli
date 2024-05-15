import { Uri, window } from "vscode";
import {
  buildScripts,
  runCommandInWorkspaceFolder,
  runCommandsFromPath,
} from "../../utils/build_runner";
import { findProjectName } from "../../utils/get-target-directory";
import { exec } from "child_process";

export const addEcosystemDomainLayer = async (args: Uri) => {
  try {
    var projectName = findProjectName(args);
    var projectPath =
      args.fsPath.split(projectName)[0] +
      projectName +
      `/${projectName}_package/lib`;
    window.showInformationMessage(projectPath);

    const name = await window.showInputBox({
      prompt: "Name of the Domain layer",
      placeHolder: "Domain layer name",
      ignoreFocusOut: true,
    });

    if (name) {
      newEcoSystemDomainLayer(name, projectName, projectPath);
    }
  } catch (error) {
    window.showErrorMessage(`Error: ${error}`);
  }
};
export async function newEcoSystemDomainLayer(
  name: string,
  projectName: string,
  projectPath: string,
  runScripts: boolean = true
) {
  const commandNewLogger = `oasis add logger --name=${name} --path=${projectPath}`;
  const commandNewDomainLayer = `oasis add domain_layer --name=${name} --project=${projectName}`;

  await runCommandsFromPath(projectPath, [
    commandNewLogger,
    commandNewDomainLayer,
  ]);

  if (runScripts) await runCommandsFromPath(projectPath, buildScripts);
}
