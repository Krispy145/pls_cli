import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:notifications/widgets/view/multi_store_view.dart";
import "package:{{project.snakeCase()}}/dependencies/injection.dart";
import "package:utilities/widgets/load_state/builder.dart";

/// [NotificationsView] of the app.
@RoutePage()
class NotificationsView extends StatelessWidget {
  /// [NotificationsView] constructor.
  NotificationsView({super.key});

  final store = Managers.notificationsStore;

  @override
  Widget build(BuildContext context) {
    return LoadStateBuilder(
      viewStore: store.pushNotificationsStore,
      emptyBuilder: (context) => const Center(
        child: Text("Empty notifications view."),
      ),
      loadedBuilder: (context) => MultiStoreNotificationsView(
        pushNotificationsStore: store.pushNotificationsStore,
        localNotificationsStore: store.localNotificationsStore,
      ),
      errorBuilder: (context) => const Center(
        child: Text("Error loading notifications view."),
      ),
    );
  }
}
