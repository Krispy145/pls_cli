import * as vscode from "vscode";

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
    }
    vscode.window.showInformationMessage(`${fileName} already exists.`);
    if (startMarker) {
      const content = appendAfterMarkerInContent(
        filePath,
        fileContent,
        startMarker
      );
      fs.writeFileSync(filePath, content);
      vscode.window.showInformationMessage(
        `${fileName} updated with new content.`
      );
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
  const camelCaseName = toCamelCase(name);
  const constantCaseName = toConstantCase(name);
  const pascalCaseName = toPascalCase(name);

  return `/// ${pascalCaseName} logger feature.\n static final LoggerFeature ${camelCaseName} = LoggerFeature("${constantCaseName}", true);\n///LOGGER FEATURE END`;
};

// Function to convert a string to camelCase
export const toCamelCase = (str: string): string => {
  return str.replace(/[-_]+(.)?/g, (_, c) => (c ? c.toUpperCase() : ""));
};

// Function to convert a string to CONSTANT_CASE
export const toConstantCase = (str: string): string => {
  return str.replace(/[-\s]+/g, "_").toUpperCase();
};

// Function to convert a string to PascalCase
export const toPascalCase = (str: string): string => {
  return str.replace(/[-_\s]+./g, (match) =>
    match.charAt(match.length - 1).toUpperCase()
  );
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
