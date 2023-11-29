import 'package:utilities/data_sources/local/hive.dart';
import 'package:utilities/logger/logger.dart';

import '../../../../utils/logger_features.dart';
import 'home_source.dart';
import '../../domain/models/home_model.dart';

/// [LocalHomeDataSource] is a class that implements [HomeDataSource] interface.
class LocalHomeDataSource extends LocalDataSource<HomeModel> implements HomeDataSource {
  // Simulated in-memory data store
  final Map<String, HomeModel> _dataStore = {};

  /// [LocalHomeDataSource] constructor.
  LocalHomeDataSource()
      : super(
          'home',
          typeAdapterId: 0,
          typeAdaptor: HomeModelAdapter(),
        );

  @override
  Future<List<HomeModel?>> search(queries) async {
    try {
      final homes = _dataStore.values.toList();
      AppLogger.print(
        "IN MEMORY RESULT: Fetched all Home models successfully",
        [AppLoggerFeatures.home],
      );
      return Future.value(homes);
    } catch (e) {
      AppLogger.print(
        "IN MEMORY RESULT: Error fetching all Home models: $e",
        [AppLoggerFeatures.home],
        type: LoggerType.error,
      );
      return [];
    }
  }
}
