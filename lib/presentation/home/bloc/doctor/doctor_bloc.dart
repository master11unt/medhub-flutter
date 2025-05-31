import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medhub/data/datasource/doctor_remote_datasource.dart';
import 'package:medhub/data/model/response/doctor_response_model.dart';

part 'doctor_event.dart';
part 'doctor_state.dart';
part 'doctor_bloc.freezed.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final DoctorRemoteDatasource datasource;
  DoctorBloc(this.datasource) : super(const DoctorState.initial()) {
    on<_FetchTopDoctors>((event, emit) async {
      emit(const DoctorState.loading());
      final result = await datasource.getDoctors();
      result.fold(
        (error) => emit(DoctorState.error(error)),
        (doctors) {
          final sorted = List<Doctor>.from(doctors)
            ..sort((a, b) =>
              (double.tryParse(b.averageRating ?? '0') ?? 0)
              .compareTo(double.tryParse(a.averageRating ?? '0') ?? 0)
            );
          emit(DoctorState.loaded(sorted.take(6).toList()));
        },
      );
    });

    on<_SearchDoctors>((event, emit) async {
      emit(const DoctorState.loading());
      final result = await datasource.getDoctors();
      result.fold(
        (error) => emit(DoctorState.error(error)),
        (doctors) {
          final filtered = doctors.where((d) =>
            (d.user?.name?.toLowerCase() ?? '').contains(event.keyword.toLowerCase()) ||
            (d.specialization?.toLowerCase() ?? '').contains(event.keyword.toLowerCase())
          ).toList();
          emit(DoctorState.loaded(filtered));
        },
      );
    });
  }
}