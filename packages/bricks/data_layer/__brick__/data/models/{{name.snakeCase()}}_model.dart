import "package:dart_mappable/dart_mappable.dart";
import "package:utilities/data/typedefs.dart";
part "{{name.snakeCase()}}_model.mapper.dart";

@MappableClass(caseStyle: CaseStyle.snakeCase)
class {{name.pascalCase()}}Model with {{name.pascalCase()}}ModelMappable {
  final UUID id;
  final String? name;

  const {{name.pascalCase()}}Model({
    required this.id,
     this.name,
  });

  static const fromMap = {{name.pascalCase()}}ModelMapper.fromMap;
  static const fromJson = {{name.pascalCase()}}ModelMapper.fromJson;

  static const empty = {{name.pascalCase()}}Model(id: "");

  static const {{name.camelCase()}}One = {{name.pascalCase()}}Model(
    id: "{{name.camelCase()}}OneId",
    name: "{{name.titleCase()}} One",    
  );
  
  static const {{name.camelCase()}}Two = {{name.pascalCase()}}Model(
    id: "{{name.camelCase()}}TwoId",
    name: "{{name.titleCase()}} Two",    
  );
  
  static const {{name.camelCase()}}Three = {{name.pascalCase()}}Model(
    id: "{{name.camelCase()}}ThreeId",
    name: "{{name.titleCase()}} Three",    
  );

  static final List<{{name.pascalCase()}}Model> fakeData = [
    {{name.camelCase()}}One,
    {{name.camelCase()}}Two,
    {{name.camelCase()}}Three,
  ];
}
