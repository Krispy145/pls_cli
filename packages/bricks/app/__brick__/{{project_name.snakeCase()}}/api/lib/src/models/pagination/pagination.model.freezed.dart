// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pagination.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PaginationModel _$PaginationModelFromJson(Map<String, dynamic> json) {
  return _PaginationModel.fromJson(json);
}

/// @nodoc
mixin _$PaginationModel {
  int get pageTotal => throw _privateConstructorUsedError;
  int get pageCurrent => throw _privateConstructorUsedError;
  int get itemsPerPage => throw _privateConstructorUsedError;
  int get itemsThisPage => throw _privateConstructorUsedError;
  int get itemsTotal => throw _privateConstructorUsedError;
  String? get nextCursor => throw _privateConstructorUsedError;
  String? get currentCursor => throw _privateConstructorUsedError;
  String? get previousCursor => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaginationModelCopyWith<PaginationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginationModelCopyWith<$Res> {
  factory $PaginationModelCopyWith(
          PaginationModel value, $Res Function(PaginationModel) then) =
      _$PaginationModelCopyWithImpl<$Res, PaginationModel>;
  @useResult
  $Res call(
      {int pageTotal,
      int pageCurrent,
      int itemsPerPage,
      int itemsThisPage,
      int itemsTotal,
      String? nextCursor,
      String? currentCursor,
      String? previousCursor});
}

/// @nodoc
class _$PaginationModelCopyWithImpl<$Res, $Val extends PaginationModel>
    implements $PaginationModelCopyWith<$Res> {
  _$PaginationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageTotal = null,
    Object? pageCurrent = null,
    Object? itemsPerPage = null,
    Object? itemsThisPage = null,
    Object? itemsTotal = null,
    Object? nextCursor = freezed,
    Object? currentCursor = freezed,
    Object? previousCursor = freezed,
  }) {
    return _then(_value.copyWith(
      pageTotal: null == pageTotal
          ? _value.pageTotal
          : pageTotal // ignore: cast_nullable_to_non_nullable
              as int,
      pageCurrent: null == pageCurrent
          ? _value.pageCurrent
          : pageCurrent // ignore: cast_nullable_to_non_nullable
              as int,
      itemsPerPage: null == itemsPerPage
          ? _value.itemsPerPage
          : itemsPerPage // ignore: cast_nullable_to_non_nullable
              as int,
      itemsThisPage: null == itemsThisPage
          ? _value.itemsThisPage
          : itemsThisPage // ignore: cast_nullable_to_non_nullable
              as int,
      itemsTotal: null == itemsTotal
          ? _value.itemsTotal
          : itemsTotal // ignore: cast_nullable_to_non_nullable
              as int,
      nextCursor: freezed == nextCursor
          ? _value.nextCursor
          : nextCursor // ignore: cast_nullable_to_non_nullable
              as String?,
      currentCursor: freezed == currentCursor
          ? _value.currentCursor
          : currentCursor // ignore: cast_nullable_to_non_nullable
              as String?,
      previousCursor: freezed == previousCursor
          ? _value.previousCursor
          : previousCursor // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PaginationModelCopyWith<$Res>
    implements $PaginationModelCopyWith<$Res> {
  factory _$$_PaginationModelCopyWith(
          _$_PaginationModel value, $Res Function(_$_PaginationModel) then) =
      __$$_PaginationModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int pageTotal,
      int pageCurrent,
      int itemsPerPage,
      int itemsThisPage,
      int itemsTotal,
      String? nextCursor,
      String? currentCursor,
      String? previousCursor});
}

/// @nodoc
class __$$_PaginationModelCopyWithImpl<$Res>
    extends _$PaginationModelCopyWithImpl<$Res, _$_PaginationModel>
    implements _$$_PaginationModelCopyWith<$Res> {
  __$$_PaginationModelCopyWithImpl(
      _$_PaginationModel _value, $Res Function(_$_PaginationModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageTotal = null,
    Object? pageCurrent = null,
    Object? itemsPerPage = null,
    Object? itemsThisPage = null,
    Object? itemsTotal = null,
    Object? nextCursor = freezed,
    Object? currentCursor = freezed,
    Object? previousCursor = freezed,
  }) {
    return _then(_$_PaginationModel(
      pageTotal: null == pageTotal
          ? _value.pageTotal
          : pageTotal // ignore: cast_nullable_to_non_nullable
              as int,
      pageCurrent: null == pageCurrent
          ? _value.pageCurrent
          : pageCurrent // ignore: cast_nullable_to_non_nullable
              as int,
      itemsPerPage: null == itemsPerPage
          ? _value.itemsPerPage
          : itemsPerPage // ignore: cast_nullable_to_non_nullable
              as int,
      itemsThisPage: null == itemsThisPage
          ? _value.itemsThisPage
          : itemsThisPage // ignore: cast_nullable_to_non_nullable
              as int,
      itemsTotal: null == itemsTotal
          ? _value.itemsTotal
          : itemsTotal // ignore: cast_nullable_to_non_nullable
              as int,
      nextCursor: freezed == nextCursor
          ? _value.nextCursor
          : nextCursor // ignore: cast_nullable_to_non_nullable
              as String?,
      currentCursor: freezed == currentCursor
          ? _value.currentCursor
          : currentCursor // ignore: cast_nullable_to_non_nullable
              as String?,
      previousCursor: freezed == previousCursor
          ? _value.previousCursor
          : previousCursor // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_PaginationModel implements _PaginationModel {
  const _$_PaginationModel(
      {required this.pageTotal,
      required this.pageCurrent,
      required this.itemsPerPage,
      required this.itemsThisPage,
      required this.itemsTotal,
      this.nextCursor,
      this.currentCursor,
      this.previousCursor});

  factory _$_PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$$_PaginationModelFromJson(json);

  @override
  final int pageTotal;
  @override
  final int pageCurrent;
  @override
  final int itemsPerPage;
  @override
  final int itemsThisPage;
  @override
  final int itemsTotal;
  @override
  final String? nextCursor;
  @override
  final String? currentCursor;
  @override
  final String? previousCursor;

  @override
  String toString() {
    return 'PaginationModel(pageTotal: $pageTotal, pageCurrent: $pageCurrent, itemsPerPage: $itemsPerPage, itemsThisPage: $itemsThisPage, itemsTotal: $itemsTotal, nextCursor: $nextCursor, currentCursor: $currentCursor, previousCursor: $previousCursor)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PaginationModel &&
            (identical(other.pageTotal, pageTotal) ||
                other.pageTotal == pageTotal) &&
            (identical(other.pageCurrent, pageCurrent) ||
                other.pageCurrent == pageCurrent) &&
            (identical(other.itemsPerPage, itemsPerPage) ||
                other.itemsPerPage == itemsPerPage) &&
            (identical(other.itemsThisPage, itemsThisPage) ||
                other.itemsThisPage == itemsThisPage) &&
            (identical(other.itemsTotal, itemsTotal) ||
                other.itemsTotal == itemsTotal) &&
            (identical(other.nextCursor, nextCursor) ||
                other.nextCursor == nextCursor) &&
            (identical(other.currentCursor, currentCursor) ||
                other.currentCursor == currentCursor) &&
            (identical(other.previousCursor, previousCursor) ||
                other.previousCursor == previousCursor));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      pageTotal,
      pageCurrent,
      itemsPerPage,
      itemsThisPage,
      itemsTotal,
      nextCursor,
      currentCursor,
      previousCursor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PaginationModelCopyWith<_$_PaginationModel> get copyWith =>
      __$$_PaginationModelCopyWithImpl<_$_PaginationModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PaginationModelToJson(
      this,
    );
  }
}

abstract class _PaginationModel implements PaginationModel {
  const factory _PaginationModel(
      {required final int pageTotal,
      required final int pageCurrent,
      required final int itemsPerPage,
      required final int itemsThisPage,
      required final int itemsTotal,
      final String? nextCursor,
      final String? currentCursor,
      final String? previousCursor}) = _$_PaginationModel;

  factory _PaginationModel.fromJson(Map<String, dynamic> json) =
      _$_PaginationModel.fromJson;

  @override
  int get pageTotal;
  @override
  int get pageCurrent;
  @override
  int get itemsPerPage;
  @override
  int get itemsThisPage;
  @override
  int get itemsTotal;
  @override
  String? get nextCursor;
  @override
  String? get currentCursor;
  @override
  String? get previousCursor;
  @override
  @JsonKey(ignore: true)
  _$$_PaginationModelCopyWith<_$_PaginationModel> get copyWith =>
      throw _privateConstructorUsedError;
}
