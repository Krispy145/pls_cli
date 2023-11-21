import 'package:notifications/models/notification.dart';
import 'package:utilities/data_sources/remote/api.dart';

/// [ApiNotificationsDataSource] is a class that implements [ApiDataSource] interface.
class ApiNotificationsDataSource extends ApiDataSource<NotificationModel> {
  /// [ApiNotificationsDataSource] constructor.
  ApiNotificationsDataSource(
    super.baseUrl,
  ) : super(sourceSuffix: 'notifications');
}
