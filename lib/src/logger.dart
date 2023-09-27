import 'package:ansi_styles/extension.dart';
import 'package:cli_util/cli_logging.dart' as util;
import 'package:interact/interact.dart';

/// Wrapper around different logging commands.
/// Used to transition from mason logger to interact
class Logger extends util.StandardLogger {
  /// A select menu to choose one option
  String chooseOne({
    required final List<String> options,
    final String prompt = "",
    int initialIndex = 0,
  }) {
    final res = Select(
      options: options,
      prompt: prompt,
      initialIndex: initialIndex,
    ).interact();
    return options[res];
  }

  /// Log info to the user, same as writing to the stdout
  void info(String message) {
    return stdout(message);
  }

  /// Prints to the stderr with styling
  void err(String message) {
    return stderr("😭 ${message.bold.redBright}");
  }

  /// Prints warning to stdout with styling
  void warn(String message) {
    return stderr("⚠️   ${message.bold.yellow}");
  }

  /// Logger implementation of Interact's spinner, for loading
  ///
  /// The icon to be shown in place of the loading
  /// indicator after it's done.
  SpinnerState spinner({
    String icon = "",
    String Function(bool)? leftPrompt,
    String Function(bool)? rightPrompt,
  }) {
    final spin = Spinner(
      icon: icon,
      rightPrompt: rightPrompt ?? (_) => "",
      leftPrompt: leftPrompt ?? (_) => "",
    ).interact();
    return spin;
  }

  /// Prompt the user for an input
  String prompt({
    required String prompt,
    bool Function(String)? validator,
    String initialText = "",
    String? defaultValue,
  }) {
    final res = Input(
      prompt: prompt,
      validator: validator,
      initialText: initialText,
      defaultValue: defaultValue,
    ).interact();
    return res;
  }

  /// Ask the user for confirmation
  bool confirm({
    required String prompt,
    bool defaultValue = false,
    bool waitForNewLine = false,
  }) {
    final answer = Confirm(
      prompt: prompt,
      defaultValue: defaultValue, // this is optional
      waitForNewLine: waitForNewLine, // optional and will be false by default
    ).interact();
    return answer;
  }
}
