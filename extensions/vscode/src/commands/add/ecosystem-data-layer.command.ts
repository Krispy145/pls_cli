import {Uri, window} from "vscode";
import {
  buildScripts,
  runCommandInWorkspaceFolder,
  runCommandsFromPath,
} from "../../utils/build_runner";
import {findProjectName} from "../../utils/get-target-directory";
import {exec} from "child_process";
import {promptForDataSourceTypes} from "../../utils/data_source_types";

export const addEcosystemDataLayer = async (args: Uri) => {
  try {
    var projectNames = findProjectName(args);
    var projectName = projectNames[0] + projectNames[1];
    var projectPath =
      args.fsPath.split(projectNames[0])[0] + projectName + `/lib`;
    window.showInformationMessage(projectPath);

    const name = await window.showInputBox({
      prompt: "Name of the Data layer",
      placeHolder: "Data layer name",
      ignoreFocusOut: true,
    });

    if (name) {
      newEcoSystemDataLayer(name, projectName[0], projectPath);
    }
  } catch (error) {
    window.showErrorMessage(`Error: ${error}`);
  }
};
export async function newEcoSystemDataLayer(
  name: string,
  projectName: string,
  projectPath: string,
  runScripts: boolean = true
) {
  var types = await promptForDataSourceTypes();

  const pickedDataSourceType = types?.map((item) => `--${item}`).join(" ");
  const commandNewLogger = `pls add logger --name=${name} --path=${projectPath}`;
  const commandNewDataLayer = `pls add data_layer --name=${name} --project=${projectName} ${pickedDataSourceType}`;
  await runCommandsFromPath(projectPath, [
    commandNewLogger,
    commandNewDataLayer,
  ]);

  if (runScripts) await runCommandsFromPath(projectPath, buildScripts);
}
