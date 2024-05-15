import { window } from "vscode";

enum DataSourceType {
  api = "api",
  assets = "assets",
  dummy = "dummy",
  firestore = "firestore",
  hive = "hive",
  secure = "secure",
  supabase = "supabase",
}

export async function promptForDataSourceTypes(): Promise<DataSourceType[]> {
  const dataSourceType = await window.showQuickPick(
    [
      {
        label: "Dummy",
        type: DataSourceType.dummy,
        picked: true,
      },
      {
        label: "API",
        type: DataSourceType.api,
      },
      {
        label: "Assets",
        type: DataSourceType.assets,
      },
      {
        label: "Firestore",
        type: DataSourceType.firestore,
      },
      {
        label: "Hive",
        type: DataSourceType.hive,
      },
      {
        label: "Secure",
        type: DataSourceType.secure,
      },
      {
        label: "Supabase",
        type: DataSourceType.supabase,
      },
    ],
    {
      canPickMany: true,
    }
  );

  if (!dataSourceType) {
    return [];
  }

  return dataSourceType.map((item) => item.type);
}
