import 'package:utilities/data_sources/remote/firestore.dart';
import 'package:utilities/logger/logger.dart';

import '../../models/{{name.snakeCase()}}_model.dart';
import '../../../utils/logger_features.dart';
import '_source.dart';

/// [Firestore{{name.pascalCase()}}DataSource] is a class that implements [{{name.pascalCase()}}DataSource] interface.
class Firestore{{name.pascalCase()}}DataSource extends FirestoreDataSource<{{name.pascalCase()}}Model> implements {{name.pascalCase()}}DataSource {
  /// [Firestore{{name.pascalCase()}}DataSource] constructor.
  Firestore{{name.pascalCase()}}DataSource()
      : super(
          '{{name.camelCase()}}',
          convertDataTypeFromMap: {{name.pascalCase()}}Model.fromJson,
          convertDataTypeToMap: (data) => data.toJson(),
        );

  /// [_handleError] is an optional helper method that handles errors when calling the Firestore.
  // ignore: unused_element
  Future<T?> _handleError<T>(Future<T?> Function() firestoreCall) async {
    try {
      return await firestoreCall();
    } catch (e) {
      AppLogger.print(
        "Firestore RESULT: Failed request: $e",
        [AppLoggerFeatures.{{name.camelCase()}}],
        type: LoggerType.error,
      );
      return null;
    }
  }
}
