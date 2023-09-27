import { exec } from "child_process";
import { resolve } from "path";
import { Uri, window } from "vscode";
import { getTargetDirectory } from "../utils/get-target-directory";

export const addPage = async (args: Uri) => {
  const name = await window.showInputBox({
    prompt: "Name of the Page",
    placeHolder: "Page name",
  });

  if (!name) {
    return;
  }
  const hasArgs = await window.showQuickPick(["Yes", "No"], {
    canPickMany: false,
    title: "Does the page have arguments?",
  });
  if (!hasArgs) {
    return;
  }
  let targetDirectory = await getTargetDirectory(args);

  const rootChild = exec(
    `render find project-root --start-dir ${targetDirectory}`
  );
  rootChild.stdout?.on("data", (data) => (rootPath = data));

  let rootPath: string | undefined;
  if (rootChild.stdout) {
    for await (const chunk of rootChild.stdout) {
      if (!rootPath) {
        rootPath = chunk;
      }
    }
  }
  if (rootPath) {
    rootPath = resolve(rootPath, "lib/navigation/route_generator.dart");
  }
  let confirmPath = await window.showInputBox({
    value: rootPath,
    title: "Path to route generator",
  });
  if (!confirmPath) {
    return;
  }

  const generatorChild = exec(`render list route-generators -p ${confirmPath}`);
  let generators: string = "";
  if (generatorChild.stdout) {
    for await (const chunk of generatorChild.stdout) {
      if (chunk && !generators) {
        generators += chunk;
      }
    }
  }

  if (!generators) {
    return;
  }
  let genList = generators.split(",");
  let generator = await window.showQuickPick(genList, {
    canPickMany: false,
    title: "Select the generator",
  });
  if (!generator) {
    return;
  }
  const command = `render add og-page --name ${name} --path ${targetDirectory} ${
    hasArgs === "Yes" && "--args"
  } --route-gen-path ${confirmPath} --generator-index ${genList.indexOf(
    generator
  )}`;

  exec(command);
};
