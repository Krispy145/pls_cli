import 'package:api/src/models/pagination/pagination.model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../json_factories.dart';
import '../../type_parser.dart';

part 'index.model.g.dart';

@JsonSerializable(explicitToJson: true)
class IndexModel<T> {
  final PaginationModel pagination;

  @_Converter()
  final List<T> data;

  IndexModel({
    required this.data,
    required this.pagination,
  });

  factory IndexModel.fromJson(Map<String, dynamic> json) =>
      _$IndexModelFromJson<T>(json);

  Map<String, dynamic> toJson() => _$IndexModelToJson(this);
}

class _Converter<T> implements JsonConverter<T, Object?> {
  const _Converter();

  @override
  T fromJson(Object? json) {
    if (json is Map<String, dynamic>) {
      final jsonFactory = factories[T];
      assert(jsonFactory != null || jsonFactory is JsonFactory<T>,
          "No Json factory found for type $T, please add it to the factories  in json_factories.dart");
      if (jsonFactory == null || jsonFactory is! JsonFactory<T>) {
        return throw "Could not find factory for type $T.";
      }
      return jsonFactory(json);
    }
    return json as T;
  }

  @override
  Object? toJson(T object) => object;
}
