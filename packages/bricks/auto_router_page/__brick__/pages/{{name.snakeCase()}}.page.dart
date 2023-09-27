import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class {{name.pascalCase()}}Page extends StatelessWidget {
  const {{name.pascalCase()}}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SizedBox(),
    );
  }
}
