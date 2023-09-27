import 'package:json_annotation/json_annotation.dart';

part 'exists.model.g.dart';

@JsonSerializable(explicitToJson: true)
class Exists {
  @JsonKey(name: "exists")
  final bool exists;

  Exists({required this.exists});

  factory Exists.fromJson(Map<String, dynamic> json) => _$ExistsFromJson(json);

  Map<String, dynamic> toJson() => _$ExistsToJson(this);
}
