import 'package:utilities/data_sources/remote/api.dart';
import 'package:utilities/logger/logger.dart';

import '../../../../utils/logger_features.dart';
import 'home_source.dart';
import '../../domain/models/home_model.dart';

/// [ApiHomeDataSource] is a class that implements [HomeDataSource] interface.
class ApiHomeDataSource extends ApiDataSource<HomeModel>
    implements HomeDataSource {
  /// [ApiHomeDataSource] constructor.
  ApiHomeDataSource(super.baseUrl) : super(sourceSuffix: baseUrl);

  /// [_handleError] is an optional helper method that handles errors when calling the API.
  // ignore: unused_element
  Future<T?> _handleError<T>(Future<T?> Function() apiCall) async {
    try {
      return await apiCall();
    } catch (e) {
      AppLogger.print(
        "API RESULT: Failed request: $e",
        [AppLoggerFeatures.home],
        type: LoggerType.error,
      );
      return null;
    }
  }
}
