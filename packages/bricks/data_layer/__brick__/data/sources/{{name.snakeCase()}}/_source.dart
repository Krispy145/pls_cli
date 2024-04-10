import 'package:utilities/data_sources/source.dart';

import '../../models/{{name.snakeCase()}}_model.dart';

/// [{{name.pascalCase()}}DataSource] is an abstract class that defines the basic CRUD operations for the [{{name.pascalCase()}}Model] entity.
abstract class {{name.pascalCase()}}DataSource extends DataSource<{{name.pascalCase()}}Model> {}
