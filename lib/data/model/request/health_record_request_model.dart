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
    final String? medicalDocument; // <-- Tambahkan ini


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

    factory HealthRecordRequestModel.fromJson(String str) => HealthRecordRequestModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory HealthRecordRequestModel.fromMap(Map<String, dynamic> json) => HealthRecordRequestModel(
        height: json["height"],
        weight: json["weight"],
        bloodType: json["blood_type"],
        birthDate: json["birth_date"] == null ? null : DateTime.parse(json["birth_date"]),
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
        "birth_date": "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
        "age": age,
        "allergies": allergies,
        "current_medications": currentMedications,
        "current_conditions": currentConditions,
        "medical_document": medicalDocument,
    };
}
