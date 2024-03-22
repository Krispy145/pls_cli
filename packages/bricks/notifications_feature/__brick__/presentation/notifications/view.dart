import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:notifications/stores/{{store_route.snakeCase()}}.dart';
import 'package:notifications/widgets/view/single_store_view.dart';
import 'package:utilities/widgets/load_state/state_widget.dart';
import '../../../dependencies/injection.dart';

/// [NotificationsView] of the app.
@RoutePage()
class NotificationsView extends StatelessWidget {
  /// [NotificationsView] constructor.
  NotificationsView({super.key});

  /// [store] is an instance of NotificationsStore, used in the [LoadStateBuilder].
  final {{store.pascalCase()}} store = Managers.notificationsStore<{{store.pascalCase()}}>();

  @override
  Widget build(BuildContext context) {
    return LoadStateBuilder(
      viewStore: store,
      emptyBuilder: (context) => const Center(
        child: Text("Empty notifications view."),
      ),
      loadedBuilder: (context) => SingleStoreNotificationsView(
        store: store,
      ),
      errorBuilder: (context) => const Center(
        child: Text("Error loading notifications view."),
      ),
    );
  }
}
