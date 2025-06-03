// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'obat_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ObatEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ObatEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ObatEvent()';
}


}

/// @nodoc
class $ObatEventCopyWith<$Res>  {
$ObatEventCopyWith(ObatEvent _, $Res Function(ObatEvent) __);
}


/// @nodoc


class _Started implements ObatEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ObatEvent.started()';
}


}




/// @nodoc


class _FetchObat implements ObatEvent {
  const _FetchObat();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchObat);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ObatEvent.fetch()';
}


}




/// @nodoc


class _SearchObat implements ObatEvent {
  const _SearchObat(this.query);
  

 final  String query;

/// Create a copy of ObatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchObatCopyWith<_SearchObat> get copyWith => __$SearchObatCopyWithImpl<_SearchObat>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchObat&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'ObatEvent.search(query: $query)';
}


}

/// @nodoc
abstract mixin class _$SearchObatCopyWith<$Res> implements $ObatEventCopyWith<$Res> {
  factory _$SearchObatCopyWith(_SearchObat value, $Res Function(_SearchObat) _then) = __$SearchObatCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class __$SearchObatCopyWithImpl<$Res>
    implements _$SearchObatCopyWith<$Res> {
  __$SearchObatCopyWithImpl(this._self, this._then);

  final _SearchObat _self;
  final $Res Function(_SearchObat) _then;

/// Create a copy of ObatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_SearchObat(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ObatState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ObatState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ObatState()';
}


}

/// @nodoc
class $ObatStateCopyWith<$Res>  {
$ObatStateCopyWith(ObatState _, $Res Function(ObatState) __);
}


/// @nodoc


class _Initial implements ObatState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ObatState.initial()';
}


}




/// @nodoc


class _Loading implements ObatState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ObatState.loading()';
}


}




/// @nodoc


class _Success implements ObatState {
  const _Success(final  List<ObatRespon> obat): _obat = obat;
  

 final  List<ObatRespon> _obat;
 List<ObatRespon> get obat {
  if (_obat is EqualUnmodifiableListView) return _obat;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_obat);
}


/// Create a copy of ObatState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&const DeepCollectionEquality().equals(other._obat, _obat));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_obat));

@override
String toString() {
  return 'ObatState.success(obat: $obat)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $ObatStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 List<ObatRespon> obat
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of ObatState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? obat = null,}) {
  return _then(_Success(
null == obat ? _self._obat : obat // ignore: cast_nullable_to_non_nullable
as List<ObatRespon>,
  ));
}


}

/// @nodoc


class _Error implements ObatState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of ObatState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ObatState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $ObatStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of ObatState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
