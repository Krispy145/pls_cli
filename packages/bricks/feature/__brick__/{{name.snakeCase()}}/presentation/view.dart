import 'package:{{project_name.snakeCase()}}/{{name.snakeCase()}}/{{name}}/presentation/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class {{name.titleCase()}}View extends StatelessWidget {
  {{name.titleCase()}}View();

  final {{name.titleCase()}}Store store = {{name.titleCase()}}Store();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (store.{{name.camelCase()}}s.isEmpty) {
          return CircularProgressIndicator();
        } else {
          return ListView.builder(
            itemCount: store.{{name.camelCase()}}s.length,
            itemBuilder: (context, index) {
              final {{name.camelCase()}} = store.{{name.camelCase()}}s[index];
              return ListTile(
                title: Text({{name.camelCase()}}.name),
                subtitle: Text('Age: ${{{name.camelCase()}}.age}'),
              );
            },
          );
        }
      },
    );
  }
}
