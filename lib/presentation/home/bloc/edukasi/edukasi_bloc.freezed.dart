// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edukasi_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EdukasiEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EdukasiEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EdukasiEvent()';
}


}

/// @nodoc
class $EdukasiEventCopyWith<$Res>  {
$EdukasiEventCopyWith(EdukasiEvent _, $Res Function(EdukasiEvent) __);
}


/// @nodoc


class _Started implements EdukasiEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EdukasiEvent.started()';
}


}




/// @nodoc


class _FetchEdukasi implements EdukasiEvent {
  const _FetchEdukasi([this.kategori]);
  

 final  String? kategori;

/// Create a copy of EdukasiEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchEdukasiCopyWith<_FetchEdukasi> get copyWith => __$FetchEdukasiCopyWithImpl<_FetchEdukasi>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchEdukasi&&(identical(other.kategori, kategori) || other.kategori == kategori));
}


@override
int get hashCode => Object.hash(runtimeType,kategori);

@override
String toString() {
  return 'EdukasiEvent.fetch(kategori: $kategori)';
}


}

/// @nodoc
abstract mixin class _$FetchEdukasiCopyWith<$Res> implements $EdukasiEventCopyWith<$Res> {
  factory _$FetchEdukasiCopyWith(_FetchEdukasi value, $Res Function(_FetchEdukasi) _then) = __$FetchEdukasiCopyWithImpl;
@useResult
$Res call({
 String? kategori
});




}
/// @nodoc
class __$FetchEdukasiCopyWithImpl<$Res>
    implements _$FetchEdukasiCopyWith<$Res> {
  __$FetchEdukasiCopyWithImpl(this._self, this._then);

  final _FetchEdukasi _self;
  final $Res Function(_FetchEdukasi) _then;

/// Create a copy of EdukasiEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? kategori = freezed,}) {
  return _then(_FetchEdukasi(
freezed == kategori ? _self.kategori : kategori // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _FetchDetail implements EdukasiEvent {
  const _FetchDetail(this.id);
  

 final  String id;

/// Create a copy of EdukasiEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchDetailCopyWith<_FetchDetail> get copyWith => __$FetchDetailCopyWithImpl<_FetchDetail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchDetail&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'EdukasiEvent.fetchDetail(id: $id)';
}


}

/// @nodoc
abstract mixin class _$FetchDetailCopyWith<$Res> implements $EdukasiEventCopyWith<$Res> {
  factory _$FetchDetailCopyWith(_FetchDetail value, $Res Function(_FetchDetail) _then) = __$FetchDetailCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class __$FetchDetailCopyWithImpl<$Res>
    implements _$FetchDetailCopyWith<$Res> {
  __$FetchDetailCopyWithImpl(this._self, this._then);

  final _FetchDetail _self;
  final $Res Function(_FetchDetail) _then;

/// Create a copy of EdukasiEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_FetchDetail(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SearchEdukasi implements EdukasiEvent {
  const _SearchEdukasi(this.query);
  

 final  String query;

/// Create a copy of EdukasiEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchEdukasiCopyWith<_SearchEdukasi> get copyWith => __$SearchEdukasiCopyWithImpl<_SearchEdukasi>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchEdukasi&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'EdukasiEvent.search(query: $query)';
}


}

/// @nodoc
abstract mixin class _$SearchEdukasiCopyWith<$Res> implements $EdukasiEventCopyWith<$Res> {
  factory _$SearchEdukasiCopyWith(_SearchEdukasi value, $Res Function(_SearchEdukasi) _then) = __$SearchEdukasiCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class __$SearchEdukasiCopyWithImpl<$Res>
    implements _$SearchEdukasiCopyWith<$Res> {
  __$SearchEdukasiCopyWithImpl(this._self, this._then);

  final _SearchEdukasi _self;
  final $Res Function(_SearchEdukasi) _then;

/// Create a copy of EdukasiEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_SearchEdukasi(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$EdukasiState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EdukasiState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EdukasiState()';
}


}

/// @nodoc
class $EdukasiStateCopyWith<$Res>  {
$EdukasiStateCopyWith(EdukasiState _, $Res Function(EdukasiState) __);
}


/// @nodoc


class EdukasiStateInitial implements EdukasiState {
  const EdukasiStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EdukasiStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EdukasiState.initial()';
}


}




/// @nodoc


class EdukasiStateLoading implements EdukasiState {
  const EdukasiStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EdukasiStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EdukasiState.loading()';
}


}




/// @nodoc


class EdukasiStateSuccess implements EdukasiState {
  const EdukasiStateSuccess(final  List<Edukasi> edukasi): _edukasi = edukasi;
  

 final  List<Edukasi> _edukasi;
 List<Edukasi> get edukasi {
  if (_edukasi is EqualUnmodifiableListView) return _edukasi;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_edukasi);
}


/// Create a copy of EdukasiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EdukasiStateSuccessCopyWith<EdukasiStateSuccess> get copyWith => _$EdukasiStateSuccessCopyWithImpl<EdukasiStateSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EdukasiStateSuccess&&const DeepCollectionEquality().equals(other._edukasi, _edukasi));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_edukasi));

@override
String toString() {
  return 'EdukasiState.success(edukasi: $edukasi)';
}


}

/// @nodoc
abstract mixin class $EdukasiStateSuccessCopyWith<$Res> implements $EdukasiStateCopyWith<$Res> {
  factory $EdukasiStateSuccessCopyWith(EdukasiStateSuccess value, $Res Function(EdukasiStateSuccess) _then) = _$EdukasiStateSuccessCopyWithImpl;
@useResult
$Res call({
 List<Edukasi> edukasi
});




}
/// @nodoc
class _$EdukasiStateSuccessCopyWithImpl<$Res>
    implements $EdukasiStateSuccessCopyWith<$Res> {
  _$EdukasiStateSuccessCopyWithImpl(this._self, this._then);

  final EdukasiStateSuccess _self;
  final $Res Function(EdukasiStateSuccess) _then;

/// Create a copy of EdukasiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? edukasi = null,}) {
  return _then(EdukasiStateSuccess(
null == edukasi ? _self._edukasi : edukasi // ignore: cast_nullable_to_non_nullable
as List<Edukasi>,
  ));
}


}

/// @nodoc


class EdukasiStateSuccessDetail implements EdukasiState {
  const EdukasiStateSuccessDetail(this.edukasi);
  

 final  Edukasi edukasi;

/// Create a copy of EdukasiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EdukasiStateSuccessDetailCopyWith<EdukasiStateSuccessDetail> get copyWith => _$EdukasiStateSuccessDetailCopyWithImpl<EdukasiStateSuccessDetail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EdukasiStateSuccessDetail&&(identical(other.edukasi, edukasi) || other.edukasi == edukasi));
}


@override
int get hashCode => Object.hash(runtimeType,edukasi);

@override
String toString() {
  return 'EdukasiState.successDetail(edukasi: $edukasi)';
}


}

/// @nodoc
abstract mixin class $EdukasiStateSuccessDetailCopyWith<$Res> implements $EdukasiStateCopyWith<$Res> {
  factory $EdukasiStateSuccessDetailCopyWith(EdukasiStateSuccessDetail value, $Res Function(EdukasiStateSuccessDetail) _then) = _$EdukasiStateSuccessDetailCopyWithImpl;
@useResult
$Res call({
 Edukasi edukasi
});




}
/// @nodoc
class _$EdukasiStateSuccessDetailCopyWithImpl<$Res>
    implements $EdukasiStateSuccessDetailCopyWith<$Res> {
  _$EdukasiStateSuccessDetailCopyWithImpl(this._self, this._then);

  final EdukasiStateSuccessDetail _self;
  final $Res Function(EdukasiStateSuccessDetail) _then;

/// Create a copy of EdukasiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? edukasi = null,}) {
  return _then(EdukasiStateSuccessDetail(
null == edukasi ? _self.edukasi : edukasi // ignore: cast_nullable_to_non_nullable
as Edukasi,
  ));
}


}

/// @nodoc


class EdukasiStateError implements EdukasiState {
  const EdukasiStateError(this.message);
  

 final  String message;

/// Create a copy of EdukasiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EdukasiStateErrorCopyWith<EdukasiStateError> get copyWith => _$EdukasiStateErrorCopyWithImpl<EdukasiStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EdukasiStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'EdukasiState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $EdukasiStateErrorCopyWith<$Res> implements $EdukasiStateCopyWith<$Res> {
  factory $EdukasiStateErrorCopyWith(EdukasiStateError value, $Res Function(EdukasiStateError) _then) = _$EdukasiStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$EdukasiStateErrorCopyWithImpl<$Res>
    implements $EdukasiStateErrorCopyWith<$Res> {
  _$EdukasiStateErrorCopyWithImpl(this._self, this._then);

  final EdukasiStateError _self;
  final $Res Function(EdukasiStateError) _then;

/// Create a copy of EdukasiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(EdukasiStateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
