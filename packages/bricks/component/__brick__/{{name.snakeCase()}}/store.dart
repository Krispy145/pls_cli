import 'package:mobx/mobx.dart';
import 'package:utilities/widgets/load_state/base_store.dart';

part 'store.g.dart';

/// [{{name.pascalCase()}}Store] is a class that uses [{{name.pascalCase()}}StoreBase] for the {{name.pascalCase()}} component.
class {{name.pascalCase()}}Store = {{name.pascalCase()}}StoreBase with _${{name.pascalCase()}}Store;

/// [{{name.pascalCase()}}StoreBase] is a class that defines the base store of the {{name.pascalCase()}} component.
abstract class {{name.pascalCase()}}StoreBase extends LoadStateStore with Store {
  /// {{name.pascalCase()}} component logic goes here.
}
