import 'package:flutter/material.dart';
import 'package:notifications/stores/local_store.dart';
import 'package:notifications/stores/push_store.dart';
import 'package:notifications/widgets/view/multi_store_view.dart';
import 'package:utilities/widgets/load_state/state_widget.dart';

import '../../dependencies/injection.dart';

/// [NotificationsView] of the app.
class NotificationsView extends StatelessWidget {
  /// [NotificationsView] constructor.
  NotificationsView({super.key});

  /// [pushNotificationsStore] is an instance of NotificationsStore, used in the [LoadStateBuilder].
  final PushNotificationsStore pushNotificationsStore = Managers.notificationsStore<PushNotificationsStore>();

  /// [localNotificationsStore] is an instance of [LocalNotificationsStore], used in the [LoadStateBuilder].
  final LocalNotificationsStore localNotificationsStore = Managers.notificationsStore<LocalNotificationsStore>();

  @override
  Widget build(BuildContext context) {
    return LoadStateBuilder(
      viewStore: pushNotificationsStore,
      emptyBuilder: (context) => const Center(
        child: Text("Empty notifications view."),
      ),
      loadedBuilder: (context) => MultiStoreNotificationsView(
        pushNotificationsStore: pushNotificationsStore,
        localNotificationsStore: localNotificationsStore,
      ),
      errorBuilder: (context) => const Center(
        child: Text("Error loading notifications view."),
      ),
    );
  }
}
