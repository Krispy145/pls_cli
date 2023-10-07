import 'package:mobx/mobx.dart';

part 'store.g.dart';

class MainViewStore = MainViewStoreBase with _$MainViewStore;

abstract class MainViewStoreBase with Store {
  @observable
  bool _isBusy = false;

  @computed
  bool get isBusy => _isBusy;

  set isBusy(bool value) {
    _isBusy = value;
  }
}
