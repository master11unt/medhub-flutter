// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RegisterEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegisterEvent()';
}


}

/// @nodoc
class $RegisterEventCopyWith<$Res>  {
$RegisterEventCopyWith(RegisterEvent _, $Res Function(RegisterEvent) __);
}


/// @nodoc


class _Started implements RegisterEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegisterEvent.started()';
}


}




/// @nodoc


class _Register implements RegisterEvent {
  const _Register({required this.name, required this.email, required this.phone, required this.password, required this.jenisKelamin, required this.noKtp});
  

 final  String name;
 final  String email;
 final  String phone;
 final  String password;
 final  String jenisKelamin;
 final  String noKtp;

/// Create a copy of RegisterEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterCopyWith<_Register> get copyWith => __$RegisterCopyWithImpl<_Register>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Register&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.password, password) || other.password == password)&&(identical(other.jenisKelamin, jenisKelamin) || other.jenisKelamin == jenisKelamin)&&(identical(other.noKtp, noKtp) || other.noKtp == noKtp));
}


@override
int get hashCode => Object.hash(runtimeType,name,email,phone,password,jenisKelamin,noKtp);

@override
String toString() {
  return 'RegisterEvent.register(name: $name, email: $email, phone: $phone, password: $password, jenisKelamin: $jenisKelamin, noKtp: $noKtp)';
}


}

/// @nodoc
abstract mixin class _$RegisterCopyWith<$Res> implements $RegisterEventCopyWith<$Res> {
  factory _$RegisterCopyWith(_Register value, $Res Function(_Register) _then) = __$RegisterCopyWithImpl;
@useResult
$Res call({
 String name, String email, String phone, String password, String jenisKelamin, String noKtp
});




}
/// @nodoc
class __$RegisterCopyWithImpl<$Res>
    implements _$RegisterCopyWith<$Res> {
  __$RegisterCopyWithImpl(this._self, this._then);

  final _Register _self;
  final $Res Function(_Register) _then;

/// Create a copy of RegisterEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? email = null,Object? phone = null,Object? password = null,Object? jenisKelamin = null,Object? noKtp = null,}) {
  return _then(_Register(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,jenisKelamin: null == jenisKelamin ? _self.jenisKelamin : jenisKelamin // ignore: cast_nullable_to_non_nullable
as String,noKtp: null == noKtp ? _self.noKtp : noKtp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$RegisterState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegisterState()';
}


}

/// @nodoc
class $RegisterStateCopyWith<$Res>  {
$RegisterStateCopyWith(RegisterState _, $Res Function(RegisterState) __);
}


/// @nodoc


class RegisterStateInitial implements RegisterState {
  const RegisterStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegisterState.initial()';
}


}




/// @nodoc


class RegisterStateLoading implements RegisterState {
  const RegisterStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegisterState.loading()';
}


}




/// @nodoc


class RegisterStateSuccess implements RegisterState {
  const RegisterStateSuccess(this.authResponseModel);
  

 final  AuthResponseModel authResponseModel;

/// Create a copy of RegisterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterStateSuccessCopyWith<RegisterStateSuccess> get copyWith => _$RegisterStateSuccessCopyWithImpl<RegisterStateSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterStateSuccess&&(identical(other.authResponseModel, authResponseModel) || other.authResponseModel == authResponseModel));
}


@override
int get hashCode => Object.hash(runtimeType,authResponseModel);

@override
String toString() {
  return 'RegisterState.success(authResponseModel: $authResponseModel)';
}


}

/// @nodoc
abstract mixin class $RegisterStateSuccessCopyWith<$Res> implements $RegisterStateCopyWith<$Res> {
  factory $RegisterStateSuccessCopyWith(RegisterStateSuccess value, $Res Function(RegisterStateSuccess) _then) = _$RegisterStateSuccessCopyWithImpl;
@useResult
$Res call({
 AuthResponseModel authResponseModel
});




}
/// @nodoc
class _$RegisterStateSuccessCopyWithImpl<$Res>
    implements $RegisterStateSuccessCopyWith<$Res> {
  _$RegisterStateSuccessCopyWithImpl(this._self, this._then);

  final RegisterStateSuccess _self;
  final $Res Function(RegisterStateSuccess) _then;

/// Create a copy of RegisterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? authResponseModel = null,}) {
  return _then(RegisterStateSuccess(
null == authResponseModel ? _self.authResponseModel : authResponseModel // ignore: cast_nullable_to_non_nullable
as AuthResponseModel,
  ));
}


}

/// @nodoc


class RegisterStateError implements RegisterState {
  const RegisterStateError(this.message);
  

 final  String message;

/// Create a copy of RegisterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterStateErrorCopyWith<RegisterStateError> get copyWith => _$RegisterStateErrorCopyWithImpl<RegisterStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'RegisterState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $RegisterStateErrorCopyWith<$Res> implements $RegisterStateCopyWith<$Res> {
  factory $RegisterStateErrorCopyWith(RegisterStateError value, $Res Function(RegisterStateError) _then) = _$RegisterStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$RegisterStateErrorCopyWithImpl<$Res>
    implements $RegisterStateErrorCopyWith<$Res> {
  _$RegisterStateErrorCopyWithImpl(this._self, this._then);

  final RegisterStateError _self;
  final $Res Function(RegisterStateError) _then;

/// Create a copy of RegisterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(RegisterStateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
