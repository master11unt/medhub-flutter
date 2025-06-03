part of 'schedule_bloc.dart';

@freezed
class ScheduleState with _$ScheduleState {
  const factory ScheduleState.initial() = ScheduleInitial;
  const factory ScheduleState.loading() = ScheduleLoading;
  const factory ScheduleState.loaded(List<ScheduleResponse> schedules) = ScheduleLoaded;
  const factory ScheduleState.error(String message) = ScheduleError;
}
