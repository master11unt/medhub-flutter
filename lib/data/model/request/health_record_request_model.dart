import 'dart:convert';

class HealthRecordRequestModel {
  final int? height;
  final int? weight;
  final String? bloodType;
  final DateTime? birthDate;
  final int? age;
  final String? allergies;
  final String? currentMedications;
  final String? currentConditions;
  final String? medicalDocument;

  HealthRecordRequestModel({
    this.height,
    this.weight,
    this.bloodType,
    this.birthDate,
    this.age,
    this.allergies,
    this.currentMedications,
    this.currentConditions,
    this.medicalDocument,
  });

  factory HealthRecordRequestModel.fromJson(String str) =>
      HealthRecordRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HealthRecordRequestModel.fromMap(Map<String, dynamic> json) =>
      HealthRecordRequestModel(
        height: json["height"],
        weight: json["weight"],
        bloodType: json["blood_type"],
        birthDate: json["birth_date"] != null 
            ? DateTime.parse(json["birth_date"]) 
            : null,
        age: json["age"],
        allergies: json["allergies"],
        currentMedications: json["current_medications"],
        currentConditions: json["current_conditions"],
        medicalDocument: json["medical_document"],
      );

  Map<String, dynamic> toMap() => {
        "height": height,
        "weight": weight,
        "blood_type": bloodType,
        "birth_date": birthDate?.toIso8601String().split('T').first,
        "age": age,
        "allergies": allergies,
        "current_medications": currentMedications,
        "current_conditions": currentConditions,
        "medical_document": medicalDocument,
      };
}
