// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeBaseStore, Store {
  Computed<HomeDataSource>? _$dataSourceComputed;

  @override
  HomeDataSource get dataSource =>
      (_$dataSourceComputed ??= Computed<HomeDataSource>(() => super.dataSource,
              name: 'HomeBaseStore.dataSource'))
          .value;
  Computed<HomeRepository>? _$repositoryComputed;

  @override
  HomeRepository get repository =>
      (_$repositoryComputed ??= Computed<HomeRepository>(() => super.repository,
              name: 'HomeBaseStore.repository'))
          .value;

  late final _$homesAtom = Atom(name: 'HomeBaseStore.homes', context: context);

  @override
  ObservableList<HomeModel?> get homes {
    _$homesAtom.reportRead();
    return super.homes;
  }

  @override
  set homes(ObservableList<HomeModel?> value) {
    _$homesAtom.reportWrite(value, super.homes, () {
      super.homes = value;
    });
  }

  late final _$loadHomeModelsAsyncAction =
      AsyncAction('HomeBaseStore.loadHomeModels', context: context);

  @override
  Future<void> loadHomeModels() {
    return _$loadHomeModelsAsyncAction.run(() => super.loadHomeModels());
  }

  @override
  String toString() {
    return '''
homes: ${homes},
dataSource: ${dataSource},
repository: ${repository}
    ''';
  }
}
