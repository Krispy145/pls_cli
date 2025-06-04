import 'package:pls_cli/cli.dart';

void main(List<String> args) async {
  final runner = CommandRunner();
  await runner.run(args);
}
