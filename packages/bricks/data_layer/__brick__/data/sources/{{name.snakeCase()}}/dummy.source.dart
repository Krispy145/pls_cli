import "package:name_template/data/models/type_tag_model.dart";
import "package:name_template/data/sources/type_tag/_source.dart";
import "package:utilities/data_sources/local/dummy_data.dart";

/// [Dummy{{name.pascalCase()}}DataSource] is a class that implements [{{name.pascalCase()}}DataSource] interface.
class Dummy{{name.pascalCase()}}DataSource extends DummyDataSource<{{name.pascalCase()}}Model> implements {{name.pascalCase()}}DataSource {
  @override
  List<{{name.pascalCase()}}Model> get fakeData => {{name.pascalCase()}}Model.fakeData;

  @override
  bool matchesID(String id, {{name.pascalCase()}}Model item) => item.id == id;
}
