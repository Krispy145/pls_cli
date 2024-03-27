import { Uri, window } from "vscode";
import { runCommandInWorkspaceFolder } from "../utils/build_runner";

export const newStructure = async (args: Uri) => {
  const structures = [
    "Default",
    "DefaultMap",
    "Map",
    "DefaultDashboard",
    "Dashboard",
  ];
  try {
    const type = await window.showQuickPick(structures, {
      placeHolder: "Select the type of structure",
    });

    if (type) {
      const commandNewStructure = `oasis add structure --type ${type}`;
      await runCommandInWorkspaceFolder(commandNewStructure, {
        folderPath: "lib/navigation",
      });
    }
  } catch (error) {
    window.showErrorMessage(`Error: ${error}`);
  }
};
