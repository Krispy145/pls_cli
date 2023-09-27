import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:render_cli/src/commands/base.dart';

/// {@template fileCommand}
///
/// Adds a dart file to a given folder. Also adds the export to the barrel file.
///
/// The barrel file will be the same name as the parent folder.
///
/// {@endtemplate}
class FileCommand extends RenderCommand {
  /// {@macro fileCommand}
  FileCommand() {
    argParser.addOption(
      "path",
      abbr: "p",
      help: "path of new file, including the file to create",
    );
  }
  @override
  String get description =>
      """Create a new dart file and add the export to a barrel file with the same name as the parent folder.
      Format: add file -p path/to/file/filename.extension      
      """;

  @override
  String get name => "file";

  @override
  FutureOr<void> run() async {
    final result = argResults;
    if (result == null || result["path"] == null) {
      logger.err("No path given");
      return;
    }

    // Create the file
    final file = await File(result["path"] as String).create(recursive: true);
    final fileName = path.basename(file.path);

    // get teh directory of the file
    final parent = file.parent;

    final barrelFile =
        File(path.join(parent.path, "_${path.basename(parent.path)}.dart"));
    // check if the barrel file exists
    if (!barrelFile.existsSync()) {
      barrelFile.createSync();
    }
    // add the export to the barrel file.
    barrelFile.writeAsStringSync('export "$fileName";', mode: FileMode.append);

    return;
  }
}
