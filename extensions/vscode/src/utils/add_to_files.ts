import * as fs from "fs";
import { getFeatureFilePath } from "./get-target-directory";
import * as vscode from "vscode";
export function appendBeforeMarkerInContent(
  content: string,
  snippet: string,
  endMarker: string
): string {
  if (content.includes(snippet)) {
    return content; // Snippet already exists, no need to append
  }
  return content.replace(new RegExp(`(${endMarker})`), `${snippet}\n$1`);
}

export function appendAfterMarkerInContent(
  content: string,
  snippet: string,
  startMarker: string
): string {
  if (content.includes(snippet)) {
    return content; // Snippet already exists, no need to append
  }
  return content.replace(new RegExp(`(${startMarker})`), `$1\n${snippet}`);
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
  injectionCode,
  getterCode,
  injectInto: injectionType,
}: {
  fileContent: string;
  storeName: string;
  injectionCode: string;
  getterCode: string;
  injectInto: string;
}) {
  try {
    const codeMarker = `;s*\ns*\ns*///END OF ${injectionType}`;
    const endMarker = "})(?![sS]*}";

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
