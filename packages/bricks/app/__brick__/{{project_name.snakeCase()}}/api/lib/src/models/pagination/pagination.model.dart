import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination.model.freezed.dart';

part 'pagination.model.g.dart';

// payload
// "pagination": {
//   "page_total": 2,
//   "page_current": 1,
//   "items_per_page": 15,
//   "items_this_page": 15,
//   "items_total": 20,
//   "next_cursor": "",
//   "current_cursor": "",
//   "previous_cursor": ""
// }

@freezed
class PaginationModel with _$PaginationModel {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PaginationModel({
    required int pageTotal,
    required int pageCurrent,
    required int itemsPerPage,
    required int itemsThisPage,
    required int itemsTotal,
    String? nextCursor,
    String? currentCursor,
    String? previousCursor,
  }) = _PaginationModel;

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson(json);
}
