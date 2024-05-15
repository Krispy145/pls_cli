import { Uri, window } from "vscode";
import {
  runCommandInWorkspaceFolder,
  runCommandsFromPath,
} from "../../utils/build_runner";
import { findProjectName } from "../../utils/get-target-directory";
import { exec } from "child_process";

export const addEcosystemPresentationLayer = async (args: Uri) => {
  try {
    var projectName = findProjectName(args);
    var projectPath = args.fsPath.split(projectName)[0] + projectName;
    window.showInformationMessage(projectPath);

    const name = await window.showInputBox({
      prompt: "Name of the Presentation layer",
      placeHolder: "Presentation layer name",
      ignoreFocusOut: true,
    });

    if (name) {
      newEcoSystemPresentationLayer(name, projectName, projectPath);
    }
  } catch (error) {
    window.showErrorMessage(`Error: ${error}`);
  }
};
export async function newEcoSystemPresentationLayer(
  name: string,
  projectName: string,
  projectPath: string,
  runScripts: boolean = true
) {
  const commandNewPresentationLayer = `oasis add ecosystem_presentation_layer --name=${name} --project=${projectName}`;
  const appDirectory = projectPath + `/${projectName}_app`;
  const dashboardDirectory = projectPath + `/${projectName}_dashboard`;
  const commandNewLogger = `oasis add logger --name=${name}`;
  await runCommandsFromPath(projectPath, [commandNewPresentationLayer]);
  if (runScripts)
    await runCommandsFromPath(`${appDirectory}/lib`, [
      commandNewLogger,
      "flutter clean",
      "flutter pub get",
      "dart format .",
      "flutter pub run build_runner build --delete-conflicting-outputs",
    ]);
  if (runScripts)
    await runCommandsFromPath(`${dashboardDirectory}/lib`, [
      commandNewLogger,
      "flutter clean",
      "flutter pub get",
      "dart format .",
      "flutter pub run build_runner build --delete-conflicting-outputs",
    ]);
}
