import 'package:flutter/material.dart';
import 'package:notifications/stores/{{store_route.snakeCase()}}.dart';
import 'package:notifications/widgets/badges/badge.dart';
import 'package:notifications/widgets/badges/badge_observer.dart';
import 'package:utilities/logger/logger.dart';
import 'package:utilities/widgets/load_state/state_widget.dart';

import '../../../navigation/routes.dart';
import '../route_data.dart';

/// [NotificationsBadgeButton] is a Button that shows the number of notifications.
/// When pressed, it navigates to the [NotificationsRoute].
class NotificationsBadgeButton extends StatelessWidget {
  /// [store] is an instance of [{{store.pascalCase()}}].
  final {{store.pascalCase()}} store;

  /// [NotificationsBadgeButton] constructor.
  const NotificationsBadgeButton({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return LoadStateBuilder(
      viewStore: store,
      loadedBuilder: (context) => NotificationBadgeObserver(
        valueListenable: store.notifications,
        builder: (context, valueListenable, child) {
          AppLogger.print(
            "valueListenable: ${valueListenable.keys}",
            [LoggerFeatures.notifications],
          );
          return NotificationBadge.count(
            showBadge: valueListenable.isNotEmpty,
            count: valueListenable.length,
            child: const Icon(Icons.notifications),
            onTap: () {
              const NotificationsRoute().go(context);
            },
          );
        },
      ),
      emptyBuilder: (context) => const Icon(Icons.notifications),
      errorBuilder: (context) => const Icon(Icons.notifications),
    );
  }
}
