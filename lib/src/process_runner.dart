import 'dart:convert';
import 'dart:io';

import 'logger.dart';

/// Runs external commands uses process run under the hood.
class ProcessRunner {
  final _logger = Logger();

  /// Runs a process and returns the result. Prints the stdout and stderr.
  Future<ProcessResult> run(
    String exec,
    List<String> args, {
    bool printOutput = true,
    bool logStderrAsError = false,
  }) async {
    final res = await Process.run(exec, args);
    final errLog = logStderrAsError ? _logger.warn : _logger.info;
    if (res.stderr != null && printOutput) {
      errLog(res.stderr.toString());
    }
    if (res.stdout != null && printOutput) {
      _logger.info(res.stdout.toString());
    }

    return res;
  }

  /// Process run with optional printing. Returns the stdout result.
  Future<String?> runResult(
    String exec,
    List<String> args, {
    bool printOutput = true,
    bool logStderrAsError = false,
  }) async {
    final res = await Process.run(exec, args);
    final errLog = logStderrAsError ? _logger.warn : _logger.info;
    if (res.stderr != null && printOutput) {
      errLog(res.stderr.toString());
    }
    if (res.stdout != null && printOutput) {
      _logger.info(res.stdout.toString());
    }

    return res.stdout as String?;
  }

  /// Runs a command until completion but prints output as it goes.
  /// Option to print both to info level instead of stderr to error.
  /// This is useful for some unix commands like git which prints everything
  /// readable to the stderr.
  Future<void> runLog(
    String exec,
    List<String> args, {
    bool logStderrAsError = false,
    String? workingDirectory,
  }) async {
    final process =
        await Process.start(exec, args, workingDirectory: workingDirectory);
    final errLog = logStderrAsError ? _logger.warn : _logger.info;
    await Future.wait<void>([
      process.stdout.transform(utf8.decoder).forEach(_logger.info),
      process.stderr.transform(utf8.decoder).forEach(errLog),
    ]);
  }

  /// Runs a string command using the underlying shell
  Future<void> runString(String command, {String? workingDirectory}) async {
    if (Platform.isWindows) {
      await runLog("cmd", ["/c", command], workingDirectory: workingDirectory);
    } else {
      await runLog("sh", ["-c", command], workingDirectory: workingDirectory);
    }
  }
}
