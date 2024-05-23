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
