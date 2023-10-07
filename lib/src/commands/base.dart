import 'dart:io';

import 'package:ansi_styles/extension.dart';
import 'package:args/command_runner.dart';
import 'package:render_cli/src/logger.dart';
import 'package:render_cli/src/process_runner.dart';

///Path for the Github CLI
const githubPath = "git@github.com:Krispy145/digital-oasis-cli.git";

/// Consistent base for all commands
abstract class RenderCommand extends Command<void> {
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
}
