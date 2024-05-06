import 'package:mobx/mobx.dart';
import "package:utilities/widgets/load_state/store.dart";
import 'domain/repositories/{{name.snakeCase()}}.repository.dart';

part 'store.g.dart';

/// [{{name.pascalCase()}}Store] is a class that uses [{{name.pascalCase()}}BaseStore] to manage state of the {{name.camelCase()}} feature.
class {{name.pascalCase()}}Store = {{name.pascalCase()}}BaseStore with _${{name.pascalCase()}}Store;

/// [{{name.pascalCase()}}BaseStore] is a class that manages the state of the {{name.camelCase()}} feature.
abstract class {{name.pascalCase()}}BaseStore extends LoadStateStore with Store {
  /// [repository] is an instance of [{{name.pascalCase()}}Repository].
  final {{name.pascalCase()}}Repository repository = {{name.pascalCase()}}Repository();

}
