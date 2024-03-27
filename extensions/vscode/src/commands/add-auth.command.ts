import { Uri, window } from "vscode";
import * as fs from "fs";
import { runCommandInWorkspaceFolder } from "../utils/build_runner";
import { getFeatureFilePath } from "../utils/get-target-directory";
import { addInjectionAndGetter } from "../utils/add_to_files";
import { addFlutterPackageFromPath } from "../utils/add_flutter_package";

export const newAuth = async (args: Uri) => {
  try {
    const commandNewAuth = `oasis add auth`;
    await runCommandInWorkspaceFolder(commandNewAuth, {
      folderPath: "lib",
    });
    // Add authentication package to pubspec.yaml
    const authenticationPath = "../../../packages/authentication";
    addFlutterPackageFromPath("authentication", authenticationPath);

    const injectionContainerPath = getFeatureFilePath(
      "lib/dependencies/injection.dart"
    );
    var fileContent = fs.readFileSync(injectionContainerPath, "utf-8");

    const injectionCode = `
    ..registerSingleton(AuthenticationRepository.supabase(logToDatabase: false))
    `;

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
  } catch (error) {
    window.showErrorMessage(`Error: ${error}`);
  }
};
