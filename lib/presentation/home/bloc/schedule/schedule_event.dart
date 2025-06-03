part of 'schedule_bloc.dart';

@freezed
class ScheduleEvent with _$ScheduleEvent {
  const factory ScheduleEvent.started() = _Started;
  const factory ScheduleEvent.fetchSchedulesByDoctorId(int doctorId) = _FetchSchedulesByDoctorId;
}