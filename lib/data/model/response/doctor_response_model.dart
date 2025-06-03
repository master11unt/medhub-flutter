import 'dart:convert';

import 'package:medhub/data/model/response/schedule_response_model.dart';

class DoctorResponseModel {
  final String? status;
  final List<Doctor>? data;

  DoctorResponseModel({this.status, this.data});

  factory DoctorResponseModel.fromJson(String str) =>
      DoctorResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DoctorResponseModel.fromMap(Map<String, dynamic> json) =>
      DoctorResponseModel(
        status: json["status"],
        data:
            json["data"] == null
                ? []
                : List<Doctor>.from(
                  json["data"]!.map((x) => Doctor.fromMap(x)),
                ),
      );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Doctor {
  final int? id;
  final int? userId;
  final String? specialization;
  final String? education;
  final String? practicePlace;
  final String? description;
  final String? licenseNumber;
  final int? isSpecialist;
  final int? isOnline;
  final int? isInConsultation;
  final dynamic averageRating; // Change from String? to dynamic
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final User? user;
  final List<ScheduleResponse>? schedules;

  Doctor({
    this.id,
    this.userId,
    this.specialization,
    this.education,
    this.practicePlace,
    this.description,
    this.licenseNumber,
    this.isSpecialist,
    this.isOnline,
    this.isInConsultation,
    this.averageRating,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.schedules,
  });

  factory Doctor.fromJson(String str) => Doctor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Doctor.fromMap(Map<String, dynamic> json) => Doctor(
    id: json["id"],
    userId: json["user_id"],
    specialization: json["specialization"],
    education: json["education"],
    practicePlace: json["practice_place"],
    description: json["description"],
    licenseNumber: json["license_number"],
    isSpecialist: json["is_specialist"],
    isOnline: json["is_online"],
    isInConsultation: json["is_in_consultation"],
    averageRating: json["average_rating"], // No more conversion needed
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    user: json["user"] == null ? null : User.fromMap(json["user"]),
    schedules:
        json["schedules"] == null
            ? []
            : List<ScheduleResponse>.from(
              json["schedules"].map((x) => ScheduleResponse.fromMap(x)),
            ),
  );

  // Dalam class Doctor:
  String? get practiceSchedule {
    if (schedules != null && schedules!.isNotEmpty) {
      final schedule = schedules![0];
      return "${schedule.day ?? ''}, ${schedule.startTime ?? ''} - ${schedule.endTime ?? ''}";
    }
    return null;
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "specialization": specialization,
    "education": education,
    "practice_place": practicePlace,
    "description": description,
    "license_number": licenseNumber,
    "is_specialist": isSpecialist,
    "is_online": isOnline,
    "is_in_consultation": isInConsultation,
    "average_rating": averageRating,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "user": user?.toMap(),
    "schedules":
        schedules == null
            ? []
            : List<dynamic>.from(schedules!.map((x) => x.toMap())),
  };
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? role;
  final String? jenisKelamin;
  final String? noKtp;
  final String? image;
  final String? token;
  final dynamic emailVerifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.role,
    this.jenisKelamin,
    this.noKtp,
    this.image,
    this.token,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    role: json["role"],
    jenisKelamin: json["jenis_kelamin"],
    noKtp: json["no_ktp"],
    image: json["image"],
    token: json["token"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "role": role,
    "jenis_kelamin": jenisKelamin,
    "no_ktp": noKtp,
    "image": image,
    "token": token,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
