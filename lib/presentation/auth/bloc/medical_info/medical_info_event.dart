part of 'medical_info_bloc.dart';

@freezed
class MedicalInfoEvent with _$MedicalInfoEvent {
  const factory MedicalInfoEvent.started() = _Started;
  const factory MedicalInfoEvent.submit({
    required int? height,
    required int? weight,
    required String? bloodType,
    required DateTime? birthDate,
    required int? age,
    required String? allergies,
    required String? currentMedications,
    required String? currentConditions,
    required String? medicalDocument,
  }) = _Submit;
  const factory MedicalInfoEvent.edit({
    required int id,
    required int? height,
    required int? weight,
    required String? bloodType,
    required DateTime? birthDate,
    required int? age,
    required String? allergies,
    required String? currentMedications,
    required String? currentConditions,
    required String? medicalDocument,
  }) = _Edit;
}