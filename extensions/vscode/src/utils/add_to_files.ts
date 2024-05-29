import * as vscode from "vscode";
import { getWorkspaceFilePath } from "./get-target-directory";
import * as fs from "fs";
import { toCamel, toPascal } from "ts-case-convert";
export function upsertFileToPathAndGetContents(
  path: string,
  fileName: string,
  fileContent: string,
  startMarker?: RegExp
) {
  const fs = require("fs");
  const filePath = `${path}/${fileName}`;
  try {
    if (!fs.existsSync(filePath)) {
      fs.writeFileSync(filePath, fileContent);
      vscode.window.showInformationMessage(`${fileName} created successfully.`);
    } else {
      vscode.window.showInformationMessage(`${fileName} already exists.`);
      if (startMarker) {
        var content = fs.readFileSync(filePath, "utf8");
        content = appendAfterMarkerInContent(content, fileContent, startMarker);
        fs.writeFileSync(filePath, content);
        vscode.window.showInformationMessage(
          `${fileName} updated with new content.`
        );
      }
    }
  } catch (error) {
    vscode.window.showErrorMessage(`Error: ${error}`);
  }
}

export function appendBeforeMarkerInContent(
  content: string,
  snippet: string,
  endMarker: RegExp
): string {
  if (content.includes(snippet)) {
    return content; // Snippet already exists, no need to append
  }
  return content.replace(endMarker, `${snippet}\n$1`);
}

export function appendAfterMarkerInContent(
  content: string,
  snippet: string,
  startMarker: RegExp
): string {
  if (content.includes(snippet)) {
    return content; // Snippet already exists, no need to append
  }
  return content.replace(startMarker, `$1\n${snippet}`);
}

// Function to create the logger feature string
export const createLoggerFeatureString = (name: string): string => {
  const camelCaseName = toCamel(name);
  const constantCaseName = toConstant(name);
  const pascalCaseName = toPascal(name);

  return `/// ${pascalCaseName} logger feature.\n static final LoggerFeature ${camelCaseName} = LoggerFeature("${constantCaseName}", true);\n/// LOGGER FEATURE END`;
};

export function addInjectionAndGetter({
  fileContent,
  storeName,
  importCode,
  injectionCode,
  getterCode,
  injectInto: injectionType,
}: {
  fileContent: string;
  storeName: string;
  importCode: string;
  injectionCode: string;
  getterCode: string;
  injectInto: string;
}) {
  const importMarker = /(import .+;)(?!.*import .+;)/;

  var codeMarker = /(\/\/\/END OF CORE)/;
  try {
    switch (injectionType) {
      case "CORE":
        codeMarker = /(;\s*\n\s*\n\s*\/\/\/END OF CORE)/;
        break;
      case "APP":
        codeMarker = /(;\s*\n\s*\n\s*\/\/\/END OF APP)/;
        break;
      case "EXTERNAL":
        codeMarker = /(;\s*\n\s*\n\s*\/\/\/END OF EXTERNAL)/;
        break;
      default:
        throw new Error(
          `Invalid injection type: ${injectionType}. Must be CORE, FEATURE or FEATURE_STORE`
        );
    }

    const endMarker = /(})(?![\s\S]*\})/;

    fileContent = appendAfterMarkerInContent(
      fileContent,
      importCode,
      importMarker
    );

    fileContent = appendBeforeMarkerInContent(
      fileContent,
      injectionCode,
      codeMarker
    );

    fileContent = appendBeforeMarkerInContent(
      fileContent,
      getterCode,
      endMarker
    );

    vscode.window.showInformationMessage(
      `${storeName} injection code added to dependencies`
    );

    return fileContent;
  } catch (error) {
    vscode.window.showErrorMessage(
      `An error occurred adding ${storeName} store: ${error}`
    );
    return fileContent;
  }
}

export function addToAndroidManifest(
  args: vscode.Uri,
  userPermissions: string[] | undefined,
  applicationAttributes: string[] | undefined,
  activityAttributes: string[] | undefined,
  activityIntentFilter: string[] | undefined
) {
  const androidManifestPath = getWorkspaceFilePath(
    args,
    "android/app/src/main/AndroidManifest.xml"
  );
  var currentAndroidContent = fs.readFileSync(androidManifestPath, "utf-8");
  try {
    if (userPermissions) {
      userPermissions.forEach((permission) => {
        if (!currentAndroidContent.includes(permission)) {
          currentAndroidContent = appendAfterMarkerInContent(
            currentAndroidContent,
            permission,
            /(\<uses-permission android:name=".+"\s*\/\>)/ //TODO: check this regexp
          );
        }
      });
    }

    if (applicationAttributes) {
      applicationAttributes.forEach((attribute) => {
        if (!currentAndroidContent.includes(attribute)) {
          currentAndroidContent = appendAfterMarkerInContent(
            currentAndroidContent,
            attribute,
            /(\<application .+\s*\/\>)/ //TODO: check this regexp
          );
        }
      });
    }

    if (activityAttributes) {
      activityAttributes.forEach((attribute) => {
        if (!currentAndroidContent.includes(attribute)) {
          currentAndroidContent = appendAfterMarkerInContent(
            currentAndroidContent,
            attribute,
            /(\<activity .+\s*\/\>)/ //TODO: check this regexp
          );
        }
      });
    }

    if (activityIntentFilter) {
      activityIntentFilter.forEach((intentFilter) => {
        if (!currentAndroidContent.includes(intentFilter)) {
          currentAndroidContent = appendAfterMarkerInContent(
            currentAndroidContent,
            intentFilter,
            /(\<intent-filter .+\s*\/\>)/ //TODO: check this regexp
          );
        }
      });
    }

    fs.writeFileSync(androidManifestPath, currentAndroidContent);
    vscode.window.showInformationMessage(
      "AndroidManifest.xml updated successfully."
    );
  } catch (error) {
    vscode.window.showErrorMessage(`Error: ${error}`);
  }
}

export function addToAppBuildGradle(
  args: vscode.Uri,
  plugins: string[] | undefined,
  dependencies: string[] | undefined
) {
  const appBuildGradlePath = getWorkspaceFilePath(
    args,
    "android/app/build.gradle"
  );
  var currentAppBuildGradleContent = fs.readFileSync(
    appBuildGradlePath,
    "utf-8"
  );
  try {
    if (dependencies) {
      dependencies.forEach((dependency) => {
        if (!currentAppBuildGradleContent.includes(dependency)) {
          currentAppBuildGradleContent = appendAfterMarkerInContent(
            currentAppBuildGradleContent,
            dependency,
            /(dependencies \{)/ //TODO: check this regexp
          );
        }
      });
    }

    if (plugins) {
      plugins.forEach((plugin) => {
        if (!currentAppBuildGradleContent.includes(plugin)) {
          currentAppBuildGradleContent = appendAfterMarkerInContent(
            currentAppBuildGradleContent,
            plugin,
            /(plugins \{)/ //TODO: check this regexp
          );
        }
      });
    }

    fs.writeFileSync(appBuildGradlePath, currentAppBuildGradleContent);
    vscode.window.showInformationMessage(
      "app/build.gradle updated successfully."
    );
  } catch (error) {
    vscode.window.showErrorMessage(`Error: ${error}`);
  }
}

export function addToIOSInfoPlist(
  args: vscode.Uri,
  ios: boolean = false,
  macos: boolean = true,
  inputs: string[] | undefined
) {
  if (ios) {
    const iosInfoPlistPath = getWorkspaceFilePath(
      args,
      "ios/Runner/Info.plist"
    );
    var currentIOSInfoPlistContent = fs.readFileSync(iosInfoPlistPath, "utf-8");
    try {
      if (inputs) {
        inputs.forEach((input) => {
          if (!currentIOSInfoPlistContent.includes(input)) {
            currentIOSInfoPlistContent = appendAfterMarkerInContent(
              currentIOSInfoPlistContent,
              input,
              /(\<dict\>)/ //TODO: check this regexp
            );
          }
        });
      }

      fs.writeFileSync(iosInfoPlistPath, currentIOSInfoPlistContent);
      vscode.window.showInformationMessage("Info.plist updated successfully.");
    } catch (error) {
      vscode.window.showErrorMessage(`Error: ${error}`);
    }
  }
  if (macos) {
    const macosInfoPlistPath = getWorkspaceFilePath(
      args,
      "macos/Runner/Info.plist"
    );
    var currentIOSInfoPlistContent = fs.readFileSync(
      macosInfoPlistPath,
      "utf-8"
    );
    try {
      if (inputs) {
        inputs.forEach((input) => {
          if (!currentIOSInfoPlistContent.includes(input)) {
            currentIOSInfoPlistContent = appendBeforeMarkerInContent(
              currentIOSInfoPlistContent,
              input,
              new RegExp("</dict>\n</plist>") //TODO: check this regexp
            );
          }
        });
      }

      fs.writeFileSync(macosInfoPlistPath, currentIOSInfoPlistContent);
      vscode.window.showInformationMessage("Info.plist updated successfully.");
    } catch (error) {
      vscode.window.showErrorMessage(`Error: ${error}`);
    }
  }
}
function toConstant(name: string) {
  return name.toUpperCase().replace(/ /g, "_").replace(/-/g, "_");
}
