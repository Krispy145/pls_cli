import "package:dart_mappable/dart_mappable.dart";

part "{{name.snakeCase()}}_model.mapper.dart";

@MappableClass(caseStyle: CaseStyle.snakeCase)
class $0Model with $0ModelMappable {
  final String id;
  final String name;

  $0Model({
    required this.id,
    required this.name,
  });

  static const fromMap = $0ModelMapper.fromMap;
  static const fromJson = $0ModelMapper.fromJson;

  static final {{name.camelCase()}}One = $0Model(
    id: "{{name.camelCase()}}OneId",
    name: "{{name.titleCase()}} One",    
  );
  
  static final {{name.camelCase()}}Two = $0Model(
    id: "{{name.camelCase()}}TwoId",
    name: "{{name.titleCase()}} Two",    
  );
  
  static final {{name.camelCase()}}Three = $0Model(
    id: "{{name.camelCase()}}ThreeId",
    name: "{{name.titleCase()}} Three",    
  );

  static final List<$0Model> fakeData = [
    {{name.camelCase()}}One,
    {{name.camelCase()}}Two,
    {{name.camelCase()}}Three,
  ];
}
