import '../../domain/models/{{name.snakeCase()}}_model.dart';
import '../../domain/repositories/{{name.snakeCase()}}_repository.dart';

/// [{{name.pascalCase()}}DataRepository] is a class that implements [{{name.pascalCase()}}Repository] interface.
class {{name.pascalCase()}}DataRepository extends {{name.pascalCase()}}Repository {
  /// [{{name.pascalCase()}}DataRepository] constructor.
  {{name.pascalCase()}}DataRepository(super.dataSource);

  @override
  Future<List<{{name.pascalCase()}}Model?>> getAll{{name.pascalCase()}}Models() async {
    return dataSource.getAll();
  }
}
