import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:notifications/widgets/view/single_store_view.dart';
import 'package:utilities/widgets/load_state/builder.dart';
import '../../../dependencies/injection.dart';

/// [NotificationsView] of the app.
@RoutePage()
class NotificationsView extends StatelessWidget {
  /// [NotificationsView] constructor.
  NotificationsView({super.key});

  final store = Managers.notificationsStore;

  @override
  Widget build(BuildContext context) {
    return LoadStateBuilder(
      viewStore: store,
      emptyBuilder: (context) => const Center(
        child: Text("Empty notifications view."),
      ),
      loadedBuilder: (context) => 
      {{#is_push}}
      Stack(children:[
        SingleStoreNotificationsView(
          store: store,
        ),
        SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () async {
                  await store.subscribePushNotificationsToTopic("the-topic");
                  Future.delayed(const Duration(seconds: 5), () async {
                    await store.sendToTopic(
                      NotificationModel(
                        id: generateUniqueId(),
                        localId: 0,
                        title: "Test Notification",
                        body: "This is a test notification.",
                        topic: "the-topic",
                      ),
                    );
                  });
                },
                child: const Text("Test Push Notification Topic"),
              ),
            ),
          ),         
      ])
      {{/is_push}}
      {{^is_push}}
      SingleStoreNotificationsView(
        store: store,
      ),
      {{/is_push}}
      errorBuilder: (context) => const Center(
        child: Text("Error loading notifications view."),
      ),
    );
  }
}
