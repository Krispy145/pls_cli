import 'package:lets_yak_cli/cli.dart';

void main(List<String> args) async {
  final runner = CommandRunner();
  await runner.run(args);
}
