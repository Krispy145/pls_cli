import 'package:mobx/mobx.dart';

part 'store.g.dart';

class {{name.pascalCase()}}ViewStore = {{name.pascalCase()}}ViewStoreBase with _${{name.pascalCase()}}ViewStore;

abstract class {{name.pascalCase()}}ViewStoreBase with Store {
  @observable
  bool _isBusy = false;

  @computed
  bool get isBusy => _isBusy;

  set isBusy(bool value) {
    _isBusy = value;
  }
}
