import 'package:{{project_name.snakeCase()}}/features/home/presentation/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomeView extends StatelessWidget {
  HomeView();

  final HomeStore store = HomeStore();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (store.homes.isEmpty) {
          return CircularProgressIndicator();
        } else {
          return ListView.builder(
            itemCount: store.homes.length,
            itemBuilder: (context, index) {
              final feature = store.homes[index];
              return ListTile(
                title: Text(feature.name),
                subtitle: Text('Age: ${feature.age}'),
              );
            },
          );
        }
      },
    );
  }
}
