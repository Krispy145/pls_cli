import 'package:mobx/mobx.dart';

part 'store.g.dart';

class {{name.pascalCase()}}Store = {{name.pascalCase()}}StoreBase with _${{name.pascalCase()}}Store;

abstract class {{name.pascalCase()}}StoreBase with Store {
  @observable
  bool _isBusy = false;

  @computed
  bool get isBusy => _isBusy;

  set isBusy(bool value) {
    _isBusy = value;
  }
}
