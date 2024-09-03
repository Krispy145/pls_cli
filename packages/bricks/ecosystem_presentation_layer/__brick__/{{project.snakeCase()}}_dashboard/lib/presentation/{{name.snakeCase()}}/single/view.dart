import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_mobx/flutter_mobx.dart";
import "package:{{project.snakeCase()}}_dashboard/presentation/group/single/store.dart";
import "package:{{project.snakeCase()}}_package/data/models/group_model.dart";
import "package:{{project.snakeCase()}}_package/presentation/group/form/store.dart";
import "package:{{project.snakeCase()}}_package/presentation/group/form/view.dart";
import "package:theme/extensions/build_context.dart";
import "package:utilities/widgets/load_state/builder.dart";

/// [GroupView] of the app.
@RoutePage()
class GroupView extends StatelessWidget {
  final String? id;
  final GroupModel? groupModel;

  /// [GroupView] constructor.
  GroupView({super.key, this.id, this.groupModel}) {
    store = AdditGroupStore(id: id, initialGroupModel: groupModel);
  }

  /// [store] is an instance of [AdditGroupStore], used in the [LoadStateBuilder].
  /// initialized in the constructor.
  late final AdditGroupStore store;
  late final groupFormStore = GroupFormStore(
    groupModel: store.currentGroup,
    saveValue: store.additGroupModel,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          groupFormStore.isAdding ? "Group Creation" : "Update ${store.currentGroup?.name}",
          style: context.textTheme.headlineMedium,
        ),
      ),
      body: Observer(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: GroupFormView(
              store: groupFormStore,
              onBack: (response) => context.router.maybePop(response),
            ),
          );
        },
      ),
    );
  }
}
