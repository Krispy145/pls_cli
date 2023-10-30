import * as fs from "fs";

export async function appendToFile(
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