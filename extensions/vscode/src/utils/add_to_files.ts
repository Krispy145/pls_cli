import * as fs from "fs";
import { getFeatureFilePath } from "./get-target-directory";
import * as vscode from "vscode";

export async function appendBeforeMarkerInFile(
  filePath: string,
  snippet: string,
  endMarker: string
): Promise<void> {
  const fileContent = fs.readFileSync(filePath, "utf-8");
  if (fileContent.includes(snippet)) {
    return; // Snippet already exists, no need to append
  }
  const updatedContent = fileContent.replace(
    new RegExp(`(${endMarker})`),
    `${snippet}\n$1`
  );
  fs.writeFileSync(filePath, updatedContent);
}

export async function appendAfterMarkerInFile(
  filePath: string,
  snippet: string,
  startMarker: string
): Promise<void> {
  const fileContent = fs.readFileSync(filePath, "utf-8");
  if (fileContent.includes(snippet)) {
    return; // Snippet already exists, no need to append
  }
  const updatedContent = fileContent.replace(
    new RegExp(`(${startMarker})`),
    `$1\n${snippet}`
  );
  fs.writeFileSync(filePath, updatedContent);
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

export async function addInjectionAndGetter({
  storeName,
  injectionCode,
  getterCode,
  injectInto: injectionType,
}: {
  storeName: string;
  injectionCode: string;
  getterCode: string;
  injectInto: string;
}) {
  const injectionContainerPath = getFeatureFilePath(
    "lib/dependencies/injection.dart"
  );

  try {
    const codeMarker = `;s*\ns*\ns*///END OF ${injectionType}`;
    const endMarker = "})(?![sS]*}";

    await appendBeforeMarkerInFile(
      injectionContainerPath,
      injectionCode,
      codeMarker
    );

    await appendBeforeMarkerInFile(
      injectionContainerPath,
      getterCode,
      endMarker
    );

    vscode.window.showInformationMessage(
      `${storeName} injection code added to dependencies`
    );
  } catch (error) {
    vscode.window.showErrorMessage(
      `An error occurred adding ${storeName} store: ${error}`
    );
  }
}
