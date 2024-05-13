import 'package:utilities/data_sources/source.dart';
import "package:utilities/data/models/basic_search_query_model.dart";
import '../../models/{{name.snakeCase()}}_model.dart';

/// [{{name.pascalCase()}}DataSource] is an mixin that defines the basic CRUD operations for the [{{name.pascalCase()}}Model] entity.
mixin {{name.pascalCase()}}DataSource on DataSource<{{name.pascalCase()}}Model, BasicSearchQueryModel> {}
