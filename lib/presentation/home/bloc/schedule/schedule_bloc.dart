import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medhub/data/datasource/schedule_remote_datasource.dart';
import 'package:medhub/data/model/response/schedule_response_model.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';
part 'schedule_bloc.freezed.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRemoteDatasource datasource;
  
  ScheduleBloc(this.datasource) : super(const ScheduleState.initial()) {
    on<_FetchSchedulesByDoctorId>((event, emit) async {
      emit(const ScheduleState.loading());
      
      try {
        final result = await datasource.getSchedulesByDoctorId(event.doctorId);
        
        result.fold(
          (errorMessage) => emit(ScheduleState.error(errorMessage)),
          (schedules) => emit(ScheduleState.loaded(schedules))
        );
      } catch (e) {
        emit(ScheduleState.error(e.toString()));
      }
    });
  }
}
