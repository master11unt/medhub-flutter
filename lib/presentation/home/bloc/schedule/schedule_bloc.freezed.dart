// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScheduleEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduleEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ScheduleEvent()';
}


}

/// @nodoc
class $ScheduleEventCopyWith<$Res>  {
$ScheduleEventCopyWith(ScheduleEvent _, $Res Function(ScheduleEvent) __);
}


/// @nodoc


class _Started implements ScheduleEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ScheduleEvent.started()';
}


}




/// @nodoc


class _FetchSchedulesByDoctorId implements ScheduleEvent {
  const _FetchSchedulesByDoctorId(this.doctorId);
  

 final  int doctorId;

/// Create a copy of ScheduleEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchSchedulesByDoctorIdCopyWith<_FetchSchedulesByDoctorId> get copyWith => __$FetchSchedulesByDoctorIdCopyWithImpl<_FetchSchedulesByDoctorId>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchSchedulesByDoctorId&&(identical(other.doctorId, doctorId) || other.doctorId == doctorId));
}


@override
int get hashCode => Object.hash(runtimeType,doctorId);

@override
String toString() {
  return 'ScheduleEvent.fetchSchedulesByDoctorId(doctorId: $doctorId)';
}


}

/// @nodoc
abstract mixin class _$FetchSchedulesByDoctorIdCopyWith<$Res> implements $ScheduleEventCopyWith<$Res> {
  factory _$FetchSchedulesByDoctorIdCopyWith(_FetchSchedulesByDoctorId value, $Res Function(_FetchSchedulesByDoctorId) _then) = __$FetchSchedulesByDoctorIdCopyWithImpl;
@useResult
$Res call({
 int doctorId
});




}
/// @nodoc
class __$FetchSchedulesByDoctorIdCopyWithImpl<$Res>
    implements _$FetchSchedulesByDoctorIdCopyWith<$Res> {
  __$FetchSchedulesByDoctorIdCopyWithImpl(this._self, this._then);

  final _FetchSchedulesByDoctorId _self;
  final $Res Function(_FetchSchedulesByDoctorId) _then;

/// Create a copy of ScheduleEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? doctorId = null,}) {
  return _then(_FetchSchedulesByDoctorId(
null == doctorId ? _self.doctorId : doctorId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$ScheduleState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduleState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ScheduleState()';
}


}

/// @nodoc
class $ScheduleStateCopyWith<$Res>  {
$ScheduleStateCopyWith(ScheduleState _, $Res Function(ScheduleState) __);
}


/// @nodoc


class ScheduleInitial implements ScheduleState {
  const ScheduleInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduleInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ScheduleState.initial()';
}


}




/// @nodoc


class ScheduleLoading implements ScheduleState {
  const ScheduleLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduleLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ScheduleState.loading()';
}


}




/// @nodoc


class ScheduleLoaded implements ScheduleState {
  const ScheduleLoaded(final  List<ScheduleResponse> schedules): _schedules = schedules;
  

 final  List<ScheduleResponse> _schedules;
 List<ScheduleResponse> get schedules {
  if (_schedules is EqualUnmodifiableListView) return _schedules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_schedules);
}


/// Create a copy of ScheduleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduleLoadedCopyWith<ScheduleLoaded> get copyWith => _$ScheduleLoadedCopyWithImpl<ScheduleLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduleLoaded&&const DeepCollectionEquality().equals(other._schedules, _schedules));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_schedules));

@override
String toString() {
  return 'ScheduleState.loaded(schedules: $schedules)';
}


}

/// @nodoc
abstract mixin class $ScheduleLoadedCopyWith<$Res> implements $ScheduleStateCopyWith<$Res> {
  factory $ScheduleLoadedCopyWith(ScheduleLoaded value, $Res Function(ScheduleLoaded) _then) = _$ScheduleLoadedCopyWithImpl;
@useResult
$Res call({
 List<ScheduleResponse> schedules
});




}
/// @nodoc
class _$ScheduleLoadedCopyWithImpl<$Res>
    implements $ScheduleLoadedCopyWith<$Res> {
  _$ScheduleLoadedCopyWithImpl(this._self, this._then);

  final ScheduleLoaded _self;
  final $Res Function(ScheduleLoaded) _then;

/// Create a copy of ScheduleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? schedules = null,}) {
  return _then(ScheduleLoaded(
null == schedules ? _self._schedules : schedules // ignore: cast_nullable_to_non_nullable
as List<ScheduleResponse>,
  ));
}


}

/// @nodoc


class ScheduleError implements ScheduleState {
  const ScheduleError(this.message);
  

 final  String message;

/// Create a copy of ScheduleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduleErrorCopyWith<ScheduleError> get copyWith => _$ScheduleErrorCopyWithImpl<ScheduleError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduleError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ScheduleState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ScheduleErrorCopyWith<$Res> implements $ScheduleStateCopyWith<$Res> {
  factory $ScheduleErrorCopyWith(ScheduleError value, $Res Function(ScheduleError) _then) = _$ScheduleErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ScheduleErrorCopyWithImpl<$Res>
    implements $ScheduleErrorCopyWith<$Res> {
  _$ScheduleErrorCopyWithImpl(this._self, this._then);

  final ScheduleError _self;
  final $Res Function(ScheduleError) _then;

/// Create a copy of ScheduleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ScheduleError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
