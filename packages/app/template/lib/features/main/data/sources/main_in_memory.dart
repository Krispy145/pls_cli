import 'package:utilities/data_sources/local/hive.dart';
import 'package:utilities/logger/logger.dart';

import '../../../../utils/logger_features.dart';
import '../../data/sources/main_source.dart';
import '../../domain/models/main_model.dart';

/// [LocalMainDataSource] is a class that implements [MainDataSource] interface.
class LocalMainDataSource extends LocalDataSource<MainModel> implements MainDataSource {
  // Simulated in-memory data store
  final Map<String, MainModel> _dataStore = {};

  /// [LocalMainDataSource] constructor.
  LocalMainDataSource()
      : super(
          'main',
          typeAdapterId: 0,
          typeAdaptor: MainModelAdapter(),
        );

  @override
  Future<List<MainModel?>> search(Map<String, String> queries) async {
    try {
      final homes = _dataStore.values.toList();
      AppLogger.print(
        "IN MEMORY RESULT: Fetched all Main models successfully",
        [AppLoggerFeatures.home],
      );
      return Future.value(homes);
    } catch (e) {
      AppLogger.print(
        "IN MEMORY RESULT: Error fetching all Main models: $e",
        [AppLoggerFeatures.home],
        type: LoggerType.error,
      );
      return [];
    }
  }
}
