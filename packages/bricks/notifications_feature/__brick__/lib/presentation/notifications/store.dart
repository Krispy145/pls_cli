import "package:mobx/mobx.dart";
import "package:notifications/models/notification.dart";
import "package:notifications/stores/local_store.dart";
import "package:notifications/stores/push_store.dart";
import "package:utilities/widgets/load_state/builder.dart";

part "store.g.dart";

/// [{{project.pascalCase()}}NotificationsStore] is a class that uses [_{{project.pascalCase()}}NotificationsStore] to manage state of the  feature.
class {{project.pascalCase()}}NotificationsStore = _{{project.pascalCase()}}NotificationsStore with _${{project.pascalCase()}}NotificationsStore;

/// [_{{project.pascalCase()}}NotificationsStore] is a class that manages the state of the  feature.
abstract class _{{project.pascalCase()}}NotificationsStore 
{{#is_push}}
  extends PushNotificationsStore
{{/is_push}}
{{^is_push}}
  extends LocalNotificationsStore
{{/is_push}}

with Store {
  
  /// _{{project.pascalCase()}}NotificationsStore constructor.
  _{{project.pascalCase()}}NotificationsStore() {
    initialize();
  }
  
  {{#is_push}}
  /// [sendToTopic] sends a notification to a topic.
  /// this function is set here to access the project's functions.
  /// the name can "sendToTopic" can be changed to any other function name.
  @action
  Future<void> sendToTopic(NotificationModel notificationModel) async {
    await pushNotificationsStore.functions.httpsCallable("sendToTopic").call<Map<String, String>>(
          notificationModel.toStringMap(),
        );
  }

  /// [subscribePushNotificationsToTopic] subscribes to a topic.
  @action
  Future<void> subscribePushNotificationsToTopic(String topic) async {
    await pushNotificationsStore.subscribeToTopic(topic);
  }
  {{/is_push}}
}
