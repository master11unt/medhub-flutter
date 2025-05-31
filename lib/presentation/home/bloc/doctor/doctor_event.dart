part of 'doctor_bloc.dart';

@freezed
class DoctorEvent with _$DoctorEvent {
  const factory DoctorEvent.started() = _Started;
  const factory DoctorEvent.fetchTopDoctors() = _FetchTopDoctors;
  const factory DoctorEvent.searchDoctors(String keyword) = _SearchDoctors;
}