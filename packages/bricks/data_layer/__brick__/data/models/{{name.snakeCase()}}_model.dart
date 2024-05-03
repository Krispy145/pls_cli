import "package:dart_mappable/dart_mappable.dart";

part "{{name.snakeCase()}}_model.mapper.dart";

@MappableClass(caseStyle: CaseStyle.snakeCase)
class {{name.pascalCase()}}Model with {{name.pascalCase()}}ModelMappable {
  final String id;
  final String name;

  {{name.pascalCase()}}Model({
    required this.id,
    required this.name,
  });

  static const fromMap = {{name.pascalCase()}}ModelMapper.fromMap;
  static const fromJson = {{name.pascalCase()}}ModelMapper.fromJson;

  static final {{name.camelCase()}}One = {{name.pascalCase()}}Model(
    id: "{{name.camelCase()}}OneId",
    name: "{{name.titleCase()}} One",    
  );
  
  static final {{name.camelCase()}}Two = {{name.pascalCase()}}Model(
    id: "{{name.camelCase()}}TwoId",
    name: "{{name.titleCase()}} Two",    
  );
  
  static final {{name.camelCase()}}Three = {{name.pascalCase()}}Model(
    id: "{{name.camelCase()}}ThreeId",
    name: "{{name.titleCase()}} Three",    
  );

  static final List<{{name.pascalCase()}}Model> fakeData = [
    {{name.camelCase()}}One,
    {{name.camelCase()}}Two,
    {{name.camelCase()}}Three,
  ];
}
