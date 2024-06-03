import { Uri, window } from "vscode";
import * as fs from "fs";
import { runCommandInWorkspaceFolder } from "../../utils/build_runner";
import { getWorkspaceFilePath } from "../../utils/get-target-directory";
import { addInjectionAndGetter } from "../../utils/add_to_files";
import { addFlutterPackageFromPath } from "../../utils/add_flutter_package";

export const addAuth = async (args: Uri) => {
  try {
    const authType = await window.showQuickPick(
      ["User Authentication", "Silent Authentication", "Both"],
      {
        title: "Select the type of authentication you want to add",
        canPickMany: false,
        ignoreFocusOut: true,
      }
    );
    while (!authType) {
      window.showQuickPick(
        ["User Authentication", "Silent Authentication", "Both"],
        {
          title: "Select the type of authentication you want to add",
          canPickMany: false,
          ignoreFocusOut: true,
        }
      );
    }
    var authTypeValue = "";
    if (authType === "User Authentication") {
      authTypeValue = "auth";
    } else if (authType === "Silent Authentication") {
      authTypeValue = "silent";
    } else {
      authTypeValue = "both";
    }

    const commandNewAuth = `oasis add auth  --${authTypeValue} --runner`;
    await runCommandInWorkspaceFolder(args, commandNewAuth, {
      folderPath: "lib",
    });
    // Add authentication package to pubspec.yaml
    const authenticationPath = "../../../packages/authentication";
    addFlutterPackageFromPath("authentication", authenticationPath);

    const injectionContainerPath = getWorkspaceFilePath(
      args,
      "lib/dependencies/injection.dart"
    );
    var fileContent = fs.readFileSync(injectionContainerPath, "utf-8");

    const injectionCode = `
    ..registerSingleton(
      AuthenticationRepository.firebase(
        //TODO: extend UserModel to include the required fields for project specific requirements
        convertDataTypeFromMap: UserModel.fromMap,
        hasPermissions: true,
        convertDataTypeToMap: (user) => user.toMap(),
      ),
    )`;

    const getterCode = `
  /// [AuthenticationRepository] getter
  AuthenticationRepository get authenticationRepository => _serviceLocator.get<AuthenticationRepository>();
  `;
    fileContent = addInjectionAndGetter({
      fileContent: fileContent,
      storeName: "Authentication",
      importCode:
        "import 'package:authentication/domain/repositories/authentication.repository.dart';",
      injectionCode,
      getterCode,
      injectInto: "CORE",
    });

    fs.writeFileSync(injectionContainerPath, fileContent);

    //opens the docs/authentication.md file from the workspace root directory
    const docsPath = getWorkspaceFilePath(args, "lib/docs/authentication.md");
    window.showTextDocument(Uri.file(docsPath));
  } catch (error) {
    window.showErrorMessage(`Error: ${error}`);
  }
};
