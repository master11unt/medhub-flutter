part of 'doctor_bloc.dart';

@freezed
class DoctorState with _$DoctorState {
  const factory DoctorState.initial() = DoctorInitial;
  const factory DoctorState.loading() = DoctorLoading;
  const factory DoctorState.loaded(List<Doctor> doctors) = DoctorLoaded;
  const factory DoctorState.error(String message) = DoctorError;
}
