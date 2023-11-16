import 'package:flutter/material.dart';
import 'package:notifications/stores/base_store.dart';
import 'package:notifications/stores/push_store.dart';
import 'package:notifications/widgets/view/view.dart';
import 'package:app_template/dependencies/injection.dart';
import 'package:utilities/widgets/load_state/state_widget.dart';

/// [NotificationsView] of the app.
class NotificationsView extends StatelessWidget {
  /// [NotificationsView] constructor.
  NotificationsView({super.key});

  /// [store] is an instance of NotificationsStore, used in the [LoadStateBuilder].
  final NotificationsStore store = Managers.notificationsStore<PushNotificationsStore>();

  @override
  Widget build(BuildContext context) {
    return LoadStateBuilder(
      viewStore: store,
      emptyBuilder: (context) => const Center(
        child: Text("Empty notifications view."),
      ),
      loadedBuilder: (context) => NotificationList(
        store: store,
      ),
      errorBuilder: (context) => const Center(
        child: Text("Error loading notifications view."),
      ),
    );
  }
}
