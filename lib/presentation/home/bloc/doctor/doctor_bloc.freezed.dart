// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'doctor_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DoctorEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoctorEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DoctorEvent()';
}


}

/// @nodoc
class $DoctorEventCopyWith<$Res>  {
$DoctorEventCopyWith(DoctorEvent _, $Res Function(DoctorEvent) __);
}


/// @nodoc


class _Started implements DoctorEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DoctorEvent.started()';
}


}




/// @nodoc


class _FetchTopDoctors implements DoctorEvent {
  const _FetchTopDoctors();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchTopDoctors);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DoctorEvent.fetchTopDoctors()';
}


}




/// @nodoc


class _SearchDoctors implements DoctorEvent {
  const _SearchDoctors(this.keyword);
  

 final  String keyword;

/// Create a copy of DoctorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchDoctorsCopyWith<_SearchDoctors> get copyWith => __$SearchDoctorsCopyWithImpl<_SearchDoctors>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchDoctors&&(identical(other.keyword, keyword) || other.keyword == keyword));
}


@override
int get hashCode => Object.hash(runtimeType,keyword);

@override
String toString() {
  return 'DoctorEvent.searchDoctors(keyword: $keyword)';
}


}

/// @nodoc
abstract mixin class _$SearchDoctorsCopyWith<$Res> implements $DoctorEventCopyWith<$Res> {
  factory _$SearchDoctorsCopyWith(_SearchDoctors value, $Res Function(_SearchDoctors) _then) = __$SearchDoctorsCopyWithImpl;
@useResult
$Res call({
 String keyword
});




}
/// @nodoc
class __$SearchDoctorsCopyWithImpl<$Res>
    implements _$SearchDoctorsCopyWith<$Res> {
  __$SearchDoctorsCopyWithImpl(this._self, this._then);

  final _SearchDoctors _self;
  final $Res Function(_SearchDoctors) _then;

/// Create a copy of DoctorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? keyword = null,}) {
  return _then(_SearchDoctors(
null == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$DoctorState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoctorState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DoctorState()';
}


}

/// @nodoc
class $DoctorStateCopyWith<$Res>  {
$DoctorStateCopyWith(DoctorState _, $Res Function(DoctorState) __);
}


/// @nodoc


class DoctorInitial implements DoctorState {
  const DoctorInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoctorInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DoctorState.initial()';
}


}




/// @nodoc


class DoctorLoading implements DoctorState {
  const DoctorLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoctorLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DoctorState.loading()';
}


}




/// @nodoc


class DoctorLoaded implements DoctorState {
  const DoctorLoaded(final  List<Doctor> doctors): _doctors = doctors;
  

 final  List<Doctor> _doctors;
 List<Doctor> get doctors {
  if (_doctors is EqualUnmodifiableListView) return _doctors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_doctors);
}


/// Create a copy of DoctorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DoctorLoadedCopyWith<DoctorLoaded> get copyWith => _$DoctorLoadedCopyWithImpl<DoctorLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoctorLoaded&&const DeepCollectionEquality().equals(other._doctors, _doctors));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_doctors));

@override
String toString() {
  return 'DoctorState.loaded(doctors: $doctors)';
}


}

/// @nodoc
abstract mixin class $DoctorLoadedCopyWith<$Res> implements $DoctorStateCopyWith<$Res> {
  factory $DoctorLoadedCopyWith(DoctorLoaded value, $Res Function(DoctorLoaded) _then) = _$DoctorLoadedCopyWithImpl;
@useResult
$Res call({
 List<Doctor> doctors
});




}
/// @nodoc
class _$DoctorLoadedCopyWithImpl<$Res>
    implements $DoctorLoadedCopyWith<$Res> {
  _$DoctorLoadedCopyWithImpl(this._self, this._then);

  final DoctorLoaded _self;
  final $Res Function(DoctorLoaded) _then;

/// Create a copy of DoctorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? doctors = null,}) {
  return _then(DoctorLoaded(
null == doctors ? _self._doctors : doctors // ignore: cast_nullable_to_non_nullable
as List<Doctor>,
  ));
}


}

/// @nodoc


class DoctorError implements DoctorState {
  const DoctorError(this.message);
  

 final  String message;

/// Create a copy of DoctorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DoctorErrorCopyWith<DoctorError> get copyWith => _$DoctorErrorCopyWithImpl<DoctorError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoctorError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'DoctorState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $DoctorErrorCopyWith<$Res> implements $DoctorStateCopyWith<$Res> {
  factory $DoctorErrorCopyWith(DoctorError value, $Res Function(DoctorError) _then) = _$DoctorErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$DoctorErrorCopyWithImpl<$Res>
    implements $DoctorErrorCopyWith<$Res> {
  _$DoctorErrorCopyWithImpl(this._self, this._then);

  final DoctorError _self;
  final $Res Function(DoctorError) _then;

/// Create a copy of DoctorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(DoctorError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
