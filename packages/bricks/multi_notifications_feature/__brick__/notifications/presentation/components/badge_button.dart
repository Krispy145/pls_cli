import 'package:flutter/material.dart';
import 'package:notifications/stores/base_store.dart';
import 'package:notifications/widgets/badges/badge.dart';
import 'package:notifications/widgets/badges/badge_observer.dart';
import 'package:utilities/logger/logger.dart';
import 'package:utilities/widgets/load_state/state_widget.dart';

import '../route_data.dart';

/// [NotificationsBadgeButton] is a Button that shows the number of notifications.
/// When pressed, it navigates to the [NotificationsRoute].
class NotificationsBadgeButton extends StatelessWidget {
  /// [store] is an instance of [NotificationsStore].
  final NotificationsStore store;

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
          return NotificationBadge.count(
            showBadge: valueListenable.isNotEmpty,
            count: valueListenable.length,
            child: const Icon(Icons.notifications),
            onTap: () {
              //! TODO: Add route to lib/navigation/routes.dart file
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
