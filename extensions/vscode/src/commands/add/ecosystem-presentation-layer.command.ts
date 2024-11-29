import {Uri, window} from "vscode";
import {
  runCommandInWorkspaceFolder,
  runCommandsFromPath,
} from "../../utils/build_runner";
import {findProjectName} from "../../utils/get-target-directory";
import {exec} from "child_process";

export const addEcosystemPresentationLayer = async (args: Uri) => {
  try {
    var projectNames = findProjectName(args);
    var projectName = projectNames[0] + projectNames[1];
    var projectPath =
      args.fsPath.split(projectNames[0])[0] + projectName + `/lib`;
    window.showInformationMessage(projectPath);

    const name = await window.showInputBox({
      prompt: "Name of the Presentation layer",
      placeHolder: "Presentation layer name",
      ignoreFocusOut: true,
    });

    if (name) {
      newEcoSystemPresentationLayer(name, projectName[0], projectPath);
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
  const commandNewPresentationLayer = `yak add ecosystem_presentation_layer --name=${name} --project=${projectName}`;
  const appDirectory = projectPath + `/${projectName}_app`;
  const dashboardDirectory = projectPath + `/${projectName}_dashboard`;
  const commandNewLogger = `yak add logger --name=${name}`;
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
