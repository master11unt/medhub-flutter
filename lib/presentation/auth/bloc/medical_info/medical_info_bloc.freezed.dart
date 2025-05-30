// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'medical_info_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MedicalInfoEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MedicalInfoEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MedicalInfoEvent()';
}


}

/// @nodoc
class $MedicalInfoEventCopyWith<$Res>  {
$MedicalInfoEventCopyWith(MedicalInfoEvent _, $Res Function(MedicalInfoEvent) __);
}


/// @nodoc


class _Started implements MedicalInfoEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MedicalInfoEvent.started()';
}


}




/// @nodoc


class _Submit implements MedicalInfoEvent {
  const _Submit({required this.height, required this.weight, required this.bloodType, required this.birthDate, required this.age, required this.allergies, required this.currentMedications, required this.currentConditions, required this.medicalDocument});
  

 final  int? height;
 final  int? weight;
 final  String? bloodType;
 final  DateTime? birthDate;
 final  int? age;
 final  String? allergies;
 final  String? currentMedications;
 final  String? currentConditions;
 final  String? medicalDocument;

/// Create a copy of MedicalInfoEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmitCopyWith<_Submit> get copyWith => __$SubmitCopyWithImpl<_Submit>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Submit&&(identical(other.height, height) || other.height == height)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.bloodType, bloodType) || other.bloodType == bloodType)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.age, age) || other.age == age)&&(identical(other.allergies, allergies) || other.allergies == allergies)&&(identical(other.currentMedications, currentMedications) || other.currentMedications == currentMedications)&&(identical(other.currentConditions, currentConditions) || other.currentConditions == currentConditions)&&(identical(other.medicalDocument, medicalDocument) || other.medicalDocument == medicalDocument));
}


@override
int get hashCode => Object.hash(runtimeType,height,weight,bloodType,birthDate,age,allergies,currentMedications,currentConditions,medicalDocument);

@override
String toString() {
  return 'MedicalInfoEvent.submit(height: $height, weight: $weight, bloodType: $bloodType, birthDate: $birthDate, age: $age, allergies: $allergies, currentMedications: $currentMedications, currentConditions: $currentConditions, medicalDocument: $medicalDocument)';
}


}

/// @nodoc
abstract mixin class _$SubmitCopyWith<$Res> implements $MedicalInfoEventCopyWith<$Res> {
  factory _$SubmitCopyWith(_Submit value, $Res Function(_Submit) _then) = __$SubmitCopyWithImpl;
@useResult
$Res call({
 int? height, int? weight, String? bloodType, DateTime? birthDate, int? age, String? allergies, String? currentMedications, String? currentConditions, String? medicalDocument
});




}
/// @nodoc
class __$SubmitCopyWithImpl<$Res>
    implements _$SubmitCopyWith<$Res> {
  __$SubmitCopyWithImpl(this._self, this._then);

  final _Submit _self;
  final $Res Function(_Submit) _then;

/// Create a copy of MedicalInfoEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? height = freezed,Object? weight = freezed,Object? bloodType = freezed,Object? birthDate = freezed,Object? age = freezed,Object? allergies = freezed,Object? currentMedications = freezed,Object? currentConditions = freezed,Object? medicalDocument = freezed,}) {
  return _then(_Submit(
height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int?,bloodType: freezed == bloodType ? _self.bloodType : bloodType // ignore: cast_nullable_to_non_nullable
as String?,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,allergies: freezed == allergies ? _self.allergies : allergies // ignore: cast_nullable_to_non_nullable
as String?,currentMedications: freezed == currentMedications ? _self.currentMedications : currentMedications // ignore: cast_nullable_to_non_nullable
as String?,currentConditions: freezed == currentConditions ? _self.currentConditions : currentConditions // ignore: cast_nullable_to_non_nullable
as String?,medicalDocument: freezed == medicalDocument ? _self.medicalDocument : medicalDocument // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _Edit implements MedicalInfoEvent {
  const _Edit({required this.id, required this.height, required this.weight, required this.bloodType, required this.birthDate, required this.age, required this.allergies, required this.currentMedications, required this.currentConditions, required this.medicalDocument});
  

 final  int id;
 final  int? height;
 final  int? weight;
 final  String? bloodType;
 final  DateTime? birthDate;
 final  int? age;
 final  String? allergies;
 final  String? currentMedications;
 final  String? currentConditions;
 final  String? medicalDocument;

/// Create a copy of MedicalInfoEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditCopyWith<_Edit> get copyWith => __$EditCopyWithImpl<_Edit>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Edit&&(identical(other.id, id) || other.id == id)&&(identical(other.height, height) || other.height == height)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.bloodType, bloodType) || other.bloodType == bloodType)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.age, age) || other.age == age)&&(identical(other.allergies, allergies) || other.allergies == allergies)&&(identical(other.currentMedications, currentMedications) || other.currentMedications == currentMedications)&&(identical(other.currentConditions, currentConditions) || other.currentConditions == currentConditions)&&(identical(other.medicalDocument, medicalDocument) || other.medicalDocument == medicalDocument));
}


@override
int get hashCode => Object.hash(runtimeType,id,height,weight,bloodType,birthDate,age,allergies,currentMedications,currentConditions,medicalDocument);

@override
String toString() {
  return 'MedicalInfoEvent.edit(id: $id, height: $height, weight: $weight, bloodType: $bloodType, birthDate: $birthDate, age: $age, allergies: $allergies, currentMedications: $currentMedications, currentConditions: $currentConditions, medicalDocument: $medicalDocument)';
}


}

/// @nodoc
abstract mixin class _$EditCopyWith<$Res> implements $MedicalInfoEventCopyWith<$Res> {
  factory _$EditCopyWith(_Edit value, $Res Function(_Edit) _then) = __$EditCopyWithImpl;
@useResult
$Res call({
 int id, int? height, int? weight, String? bloodType, DateTime? birthDate, int? age, String? allergies, String? currentMedications, String? currentConditions, String? medicalDocument
});




}
/// @nodoc
class __$EditCopyWithImpl<$Res>
    implements _$EditCopyWith<$Res> {
  __$EditCopyWithImpl(this._self, this._then);

  final _Edit _self;
  final $Res Function(_Edit) _then;

/// Create a copy of MedicalInfoEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? height = freezed,Object? weight = freezed,Object? bloodType = freezed,Object? birthDate = freezed,Object? age = freezed,Object? allergies = freezed,Object? currentMedications = freezed,Object? currentConditions = freezed,Object? medicalDocument = freezed,}) {
  return _then(_Edit(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int?,bloodType: freezed == bloodType ? _self.bloodType : bloodType // ignore: cast_nullable_to_non_nullable
as String?,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,allergies: freezed == allergies ? _self.allergies : allergies // ignore: cast_nullable_to_non_nullable
as String?,currentMedications: freezed == currentMedications ? _self.currentMedications : currentMedications // ignore: cast_nullable_to_non_nullable
as String?,currentConditions: freezed == currentConditions ? _self.currentConditions : currentConditions // ignore: cast_nullable_to_non_nullable
as String?,medicalDocument: freezed == medicalDocument ? _self.medicalDocument : medicalDocument // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$MedicalInfoState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MedicalInfoState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MedicalInfoState()';
}


}

/// @nodoc
class $MedicalInfoStateCopyWith<$Res>  {
$MedicalInfoStateCopyWith(MedicalInfoState _, $Res Function(MedicalInfoState) __);
}


/// @nodoc


class MedicalInfoInitial implements MedicalInfoState {
  const MedicalInfoInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MedicalInfoInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MedicalInfoState.initial()';
}


}




/// @nodoc


class MedicalInfoLoading implements MedicalInfoState {
  const MedicalInfoLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MedicalInfoLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MedicalInfoState.loading()';
}


}




/// @nodoc


class MedicalInfoSuccess implements MedicalInfoState {
  const MedicalInfoSuccess(this.data);
  

 final  HealthRecordResponseModel data;

/// Create a copy of MedicalInfoState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MedicalInfoSuccessCopyWith<MedicalInfoSuccess> get copyWith => _$MedicalInfoSuccessCopyWithImpl<MedicalInfoSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MedicalInfoSuccess&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'MedicalInfoState.success(data: $data)';
}


}

/// @nodoc
abstract mixin class $MedicalInfoSuccessCopyWith<$Res> implements $MedicalInfoStateCopyWith<$Res> {
  factory $MedicalInfoSuccessCopyWith(MedicalInfoSuccess value, $Res Function(MedicalInfoSuccess) _then) = _$MedicalInfoSuccessCopyWithImpl;
@useResult
$Res call({
 HealthRecordResponseModel data
});




}
/// @nodoc
class _$MedicalInfoSuccessCopyWithImpl<$Res>
    implements $MedicalInfoSuccessCopyWith<$Res> {
  _$MedicalInfoSuccessCopyWithImpl(this._self, this._then);

  final MedicalInfoSuccess _self;
  final $Res Function(MedicalInfoSuccess) _then;

/// Create a copy of MedicalInfoState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(MedicalInfoSuccess(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as HealthRecordResponseModel,
  ));
}


}

/// @nodoc


class MedicalInfoError implements MedicalInfoState {
  const MedicalInfoError(this.message);
  

 final  String message;

/// Create a copy of MedicalInfoState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MedicalInfoErrorCopyWith<MedicalInfoError> get copyWith => _$MedicalInfoErrorCopyWithImpl<MedicalInfoError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MedicalInfoError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'MedicalInfoState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $MedicalInfoErrorCopyWith<$Res> implements $MedicalInfoStateCopyWith<$Res> {
  factory $MedicalInfoErrorCopyWith(MedicalInfoError value, $Res Function(MedicalInfoError) _then) = _$MedicalInfoErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$MedicalInfoErrorCopyWithImpl<$Res>
    implements $MedicalInfoErrorCopyWith<$Res> {
  _$MedicalInfoErrorCopyWithImpl(this._self, this._then);

  final MedicalInfoError _self;
  final $Res Function(MedicalInfoError) _then;

/// Create a copy of MedicalInfoState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(MedicalInfoError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
