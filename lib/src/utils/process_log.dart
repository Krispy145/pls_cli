import 'dart:convert';
import 'dart:io';

import 'package:mason/mason.dart';

/// Run and log a shell command.
///
/// Returns the stdout
String processRunLog(String exec, List<String> args) {
  final logger = Logger();
  final process = Process.runSync(exec, args);
  final dynamic result = process.stdout;

  logger.write(result as String);
  if (process.stderr != null || process.stderr != "") {
    logger.err(process.stderr.toString());
  }
  return result;
}

/// Start a command and stream stdout
Future<void> processStartLog(String exec, List<String> args) async {
  final logger = Logger();
  final process = await Process.start(exec, args);
  await Future.wait<void>([
    process.stderr.transform(utf8.decoder).forEach(logger.err),
    process.stdout.transform(utf8.decoder).forEach(logger.write),
  ]);
}

/// Run a single command string
Future<void> runShellCommand(String command) async {
  if (Platform.isWindows) {
    await processStartLog("cmd", ["/c", command]);
  } else {
    await processStartLog("sh", ["-c", command]);
  }
}
