import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medhub/data/datasource/health_record_remote_datasource.dart';
import 'package:medhub/data/model/request/health_record_request_model.dart';
import 'package:medhub/data/model/response/health_record_response_model.dart';

part 'medical_info_event.dart';
part 'medical_info_state.dart';
part 'medical_info_bloc.freezed.dart';

class MedicalInfoBloc extends Bloc<MedicalInfoEvent, MedicalInfoState> {
  final HealthRecordRemoteDatasource datasource;
  final String token;
  
  MedicalInfoBloc(this.datasource, this.token) : super(MedicalInfoInitial()) {
    // Submit (tambah data)
    on<_Submit>((event, emit) async {
      emit(const MedicalInfoLoading());
      try {
        final request = HealthRecordRequestModel(
          height: event.height,
          weight: event.weight,
          bloodType: event.bloodType,
          birthDate: event.birthDate,
          age: event.age,
          allergies: event.allergies,
          currentMedications: event.currentMedications,
          currentConditions: event.currentConditions,
          medicalDocument: event.medicalDocument,
        );
        final result = await datasource.submitHealthRecord(request, token);
        emit(MedicalInfoSuccess(result));
      } catch (e) {
        emit(MedicalInfoError(e.toString()));
      }
    });

    // Edit (update data)
    on<_Edit>((event, emit) async {
      emit(const MedicalInfoLoading());
      try {
        final request = HealthRecordRequestModel(
          height: event.height,
          weight: event.weight,
          bloodType: event.bloodType,
          birthDate: event.birthDate,
          age: event.age,
          allergies: event.allergies,
          currentMedications: event.currentMedications,
          currentConditions: event.currentConditions,
          medicalDocument: event.medicalDocument,
        );
        final result = await datasource.updateHealthRecord(event.id, request, token);
        emit(MedicalInfoSuccess(result));
      } catch (e) {
        emit(MedicalInfoError(e.toString()));
      }
    });
  }
}
