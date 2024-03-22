import 'dart:io';
import 'package:ansi_styles/extension.dart';
import 'package:args/command_runner.dart';
import 'package:unpack_cli/src/logger.dart';
import 'package:unpack_cli/src/process_runner.dart';

///Path for the Github CLI
const githubPath = "git@github.com:digital-oasis-llc-fz/digital-oasis-cli.git";

/// Consistent base for all commands
abstract class UnpackCommand extends Command<void> {
  /// Logger for all commands
  Logger get logger => Logger();

  /// Consistent runner for all commands
  ProcessRunner get processRunner => ProcessRunner();

  /// Run Scripts for bricks
  Future<void> runScripts(List<String> scripts) async {
    // Run the scripts one by one
    for (final script in scripts) {
      logger.info('Running script: $script');
      final processResult = await Process.run('sh', ['-c', script]);

      if (processResult.exitCode == 0) {
        logger.info('Script executed successfully.'.green);
      } else {
        logger
          ..err('Error executing script:')
          ..err(processResult.stdout.toString())
          ..err(processResult.stderr.toString());
      }
    }
  }

  /// Runs the function from the root lib directory
  Future<void> runInLibDirectory(
    Future<void> Function() function, {
    String? extensionPath,
  }) async {
    // Get the current directory
    var currentDirectory = Directory.current;

    // Define the name of the root folder you want to reach (e.g., 'lib')
    const rootFolderName = 'lib';

    // Variable to store the original working directory
    final originalDirectory = currentDirectory.path;

    try {
      // Loop through the parent directories until you reach the root folder
      while (currentDirectory.path != '/' && !currentDirectory.path.endsWith(rootFolderName)) {
        currentDirectory = currentDirectory.parent;
      }

      // Check if you've reached the root folder
      if (currentDirectory.path.endsWith(rootFolderName)) {
        if (extensionPath != null) {
          // Get the extension directory
          final extensionDirectory = Directory.fromUri(currentDirectory.uri.resolve(extensionPath));

          // Check if the directory exists
          if (!extensionDirectory.existsSync()) {
            // If it doesn't exist, create it
            extensionDirectory.createSync(recursive: true);
          }

          // Change the working directory to the extension folder
          Directory.current = extensionDirectory;
        } else {
          // Get the lib directory
          final libDirectory = Directory.fromUri(currentDirectory.uri.resolve('lib'));

          // Change the working directory to the lib folder
          Directory.current = libDirectory;
        }

        // Run the provided function
        await function();
      } else {
        // The root folder was not found
        logger.err('Root "$rootFolderName" folder not found.');
      }
    } finally {
      // Restore the original working directory
      Directory.current = Directory(originalDirectory);
    }
  }
}
