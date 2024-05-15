import { Uri, window } from "vscode";
import { findProjectName } from "../../utils/get-target-directory";
import { newEcoSystemDataLayer } from "./ecosystem-data-layer.command";
import { newEcoSystemDomainLayer } from "./ecosystem-domain-layer.command";
import { newEcoSystemPresentationLayer } from "./ecosystem-presentation-layer.command";
import { buildScripts, runCommandsFromPath } from "../../utils/build_runner";

export const addEcosystemFeature = async (args: Uri) => {
  try {
    var projectName = findProjectName(args);
    var projectPath = args.fsPath.split(projectName)[0] + projectName;

    var packageExtension = `/${projectName}_package/lib`;
    var appExtension = `/${projectName}_app/lib`;
    var dashboardExtension = `/${projectName}_dashboard/lib`;
    window.showInformationMessage(projectPath);

    const name = await window.showInputBox({
      prompt: "Name of the Feature",
      placeHolder: "Feature name",
      ignoreFocusOut: true,
    });

    if (name) {
      await newEcoSystemDataLayer(
        name,
        projectName + "_package",
        projectPath + packageExtension,
        false
      );
      await newEcoSystemDomainLayer(
        name,
        projectName + "_package",
        projectPath + packageExtension,
        false
      );
      await newEcoSystemPresentationLayer(
        name,
        projectName,
        projectPath,
        false
      );
      window.showInformationMessage("Feature created successfully");
      window.showInformationMessage("Running build_runner");
      await runCommandsFromPath(projectPath + appExtension, buildScripts);
      await runCommandsFromPath(projectPath + dashboardExtension, buildScripts);
      await runCommandsFromPath(projectPath + packageExtension, buildScripts);
    }
  } catch (error) {
    window.showErrorMessage(`Error: ${error}`);
  }
};
