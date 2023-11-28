import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notifications/models/notification.dart';
import 'package:notifications/stores/local_store.dart';
import 'package:{{project_name.snakeCase()}}/dependencies/injection.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:utilities/widgets/load_state/state_widget.dart';

import 'store.dart';

/// [MainView] of the app.
class MainView extends StatelessWidget {
  /// [MainView] constructor.
  MainView({super.key});

  /// [store] is an instance of [MainStore], used in the [LoadStateBuilder].
  final MainStore store = MainStore()..loadMainModels();

  /// [localNotificationsStore] is an instance of [LocalNotificationsStore], used to show a notification.
  final LocalNotificationsStore localNotificationsStore =
      Managers.notificationsStore<LocalNotificationsStore>();

  @override
  Widget build(BuildContext context) {
    return LoadStateBuilder(
      viewStore: store,
      emptyBuilder: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => localNotificationsStore.zonedSchedule(
                time:
                    tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
                notification: NotificationModel(
                  id: localNotificationsStore.generateUniqueId(),
                  localId: Random().nextInt(1000),
                  title: 'Test local',
                  body: 'Test local body',
                ),
                details: localNotificationsStore.notificationDetails(),
              ),
              child: const Text("Test Local Notification"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () => localNotificationsStore.requestPermissions(null),
              child: const Text("Request Notifications Permission"),
            ),
          ],
        ),
      ),
      loadedBuilder: (context) => ListView.builder(
        itemCount: store.mains.length,
        itemBuilder: (context, index) {
          final mainModel = store.mains[index]!;
          return ListTile(
            title: Text('Name: ${mainModel.name}'),
            subtitle: Text('Age: ${mainModel.age}'),
          );
        },
      ),
      errorBuilder: (context) => const Center(
        child: Text("Error loading main view."),
      ),
    );
  }
}
