import * as fs from "fs";

export async function appendBeforeMarkerInFile(
  filePath: string,
  snippet: string,
  endMarker: string
): Promise<void> {
  const fileContent = fs.readFileSync(filePath, "utf-8");
  if (fileContent.includes(snippet)) {
    return;
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
