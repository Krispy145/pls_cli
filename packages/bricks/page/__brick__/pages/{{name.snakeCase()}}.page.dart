import 'package:flutter/material.dart';

{{#args}}
class {{name.pascalCase()}}PageArguments {
  const {{name.pascalCase()}}PageArguments();
}
{{/args}}

class {{name.pascalCase()}}Page extends StatelessWidget {
  static const routeName = "{{name.camelCase()}}";
  const {{name.pascalCase()}}Page({Key? key{{#args}}, {{name.pascalCase()}}PageArguments? args{{/args}}}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SizedBox(),
    );
  }
}
