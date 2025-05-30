part of 'medical_info_bloc.dart';

@freezed
class MedicalInfoState with _$MedicalInfoState {
  const factory MedicalInfoState.initial() = MedicalInfoInitial;
  const factory MedicalInfoState.loading() = MedicalInfoLoading;
  const factory MedicalInfoState.success(HealthRecordResponseModel data) = MedicalInfoSuccess;
  const factory MedicalInfoState.error(String message) = MedicalInfoError;
}
