// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MainStore on MainBaseStore, Store {
  late final _$mainsAtom = Atom(name: 'MainBaseStore.mains', context: context);

  @override
  ObservableList<MainModel?> get mains {
    _$mainsAtom.reportRead();
    return super.mains;
  }

  @override
  set mains(ObservableList<MainModel?> value) {
    _$mainsAtom.reportWrite(value, super.mains, () {
      super.mains = value;
    });
  }

  late final _$loadMainModelsAsyncAction =
      AsyncAction('MainBaseStore.loadMainModels', context: context);

  @override
  Future<void> loadMainModels() {
    return _$loadMainModelsAsyncAction.run(() => super.loadMainModels());
  }

  @override
  String toString() {
    return '''
mains: ${mains}
    ''';
  }
}
