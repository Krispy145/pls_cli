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
}
