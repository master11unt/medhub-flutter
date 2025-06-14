part of 'register_bloc.dart';

@freezed
class RegisterEvent with _$RegisterEvent {
  const factory RegisterEvent.started() = _Started;
  const factory RegisterEvent.register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String jenisKelamin,
    required String noKtp,
  }) = _Register;
}