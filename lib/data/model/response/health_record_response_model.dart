import 'dart:convert';

class HealthRecordResponseModel {
    final String? status;
    final Data? data;

    HealthRecordResponseModel({
        this.status,
        this.data,
    });

    factory HealthRecordResponseModel.fromJson(String str) => HealthRecordResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory HealthRecordResponseModel.fromMap(Map<String, dynamic> json) => HealthRecordResponseModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "data": data?.toMap(),
    };
}

class Data {
    final int? id;
    final int? userId;
    final int? height;
    final int? weight;
    final String? bloodType;
    final DateTime? birthDate;
    final int? age;
    final String? allergies;
    final String? currentMedications;
    final String? currentConditions;
    final dynamic medicalDocument;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Data({
        this.id,
        this.userId,
        this.height,
        this.weight,
        this.bloodType,
        this.birthDate,
        this.age,
        this.allergies,
        this.currentMedications,
        this.currentConditions,
        this.medicalDocument,
        this.createdAt,
        this.updatedAt,
    });

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        height: json["height"],
        weight: json["weight"],
        bloodType: json["blood_type"],
        birthDate: json["birth_date"] == null ? null : DateTime.parse(json["birth_date"]),
        age: json["age"],
        allergies: json["allergies"],
        currentMedications: json["current_medications"],
        currentConditions: json["current_conditions"],
        medicalDocument: json["medical_document"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "height": height,
        "weight": weight,
        "blood_type": bloodType,
        "birth_date": birthDate?.toIso8601String(),
        "age": age,
        "allergies": allergies,
        "current_medications": currentMedications,
        "current_conditions": currentConditions,
        "medical_document": medicalDocument,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
