import 'package:utilities/data_sources/remote/api.dart';
import 'package:utilities/logger/logger.dart';

import '../../../../utils/logger_features.dart';
import '../../data/sources/main_source.dart';
import '../../domain/models/main_model.dart';

/// [ApiMainDataSource] is a class that implements [MainDataSource] interface.
class ApiMainDataSource extends ApiDataSource<MainModel>
    implements MainDataSource {
  /// [ApiMainDataSource] constructor.
  ApiMainDataSource(super.baseUrl) : super(sourceSuffix: baseUrl);

  /// [_handleError] is an optional helper method that handles errors when calling the API.
  // ignore: unused_element
  Future<T?> _handleError<T>(Future<T?> Function() apiCall) async {
    try {
      return await apiCall();
    } catch (e) {
      AppLogger.print(
        "API RESULT: Failed request: $e",
        [AppLoggerFeatures.main],
        type: LoggerType.error,
      );
      return null;
    }
  }
}
