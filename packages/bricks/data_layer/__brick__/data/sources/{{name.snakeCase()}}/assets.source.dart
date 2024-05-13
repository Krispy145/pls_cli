import 'package:parent_name_template/utils/loggers.dart';
import 'package:utilities/data_sources/local/assets.dart';
import "package:utilities/data/models/basic_search_query_model.dart";
import 'package:utilities/logger/logger.dart';

import '../../models/{{name.snakeCase()}}_model.dart';
import '_source.dart';

/// [Assets{{name.pascalCase()}}DataSource] is a class that implements [{{name.pascalCase()}}DataSource] interface.
class Assets{{name.pascalCase()}}DataSource extends AssetsDataSource<{{name.pascalCase()}}Model, BasicSearchQueryModel> implements {{name.pascalCase()}}DataSource {
  /// [Assets{{name.pascalCase()}}DataSource] constructor.
  Assets{{name.pascalCase()}}DataSource()
      : super(
          //TODO: Replace the following key with the actual assets key.
          rootBundleKey: 'assets/{{name.snakeCase()}}/list.json',
          convertDataTypeFromMap: {{name.pascalCase()}}Model.fromMap,
          convertDataTypeToMap: (data) => data.toMap(),
        );

  @override
  bool matchesQuery(BasicSearchQueryModel query, {{name.pascalCase()}}Model item) {
    // TODO: implement matchesQuery
    throw UnimplementedError();
  }
}
