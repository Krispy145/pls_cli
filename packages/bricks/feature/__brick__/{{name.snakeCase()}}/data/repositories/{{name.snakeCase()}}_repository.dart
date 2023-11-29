import '../../domain/models/{{name.snakeCase()}}_model.dart';
import '../../domain/repositories/{{name.snakeCase()}}_repository.dart';
import '../sources/{{name.snakeCase()}}_source.dart';

/// [{{name.pascalCase()}}DataRepository] is a class that implements [{{name.pascalCase()}}Repository] interface.
class {{name.pascalCase()}}DataRepository extends {{name.pascalCase()}}Repository {
  /// [dataSource] is an instance of [{{name.pascalCase()}}DataSource], specifically the in memory data source.
  final {{name.pascalCase()}}DataSource dataSource;

  /// [{{name.pascalCase()}}DataRepository] constructor.
  {{name.pascalCase()}}DataRepository(this.dataSource);

  @override
  Future<List<{{name.pascalCase()}}Model?>> getAll{{name.pascalCase()}}Models() async {
    return dataSource.getAll();
  }
}
