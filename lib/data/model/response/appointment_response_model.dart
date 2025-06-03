import 'dart:convert';

class AppointmentResponseModel {
    final String? status;
    final List<AppointmentData>? data;

    AppointmentResponseModel({
        this.status,
        this.data,
    });

    factory AppointmentResponseModel.fromJson(String str) => AppointmentResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AppointmentResponseModel.fromMap(Map<String, dynamic> json) => AppointmentResponseModel(
        status: json["status"],
        data: json["data"] == null ? [] : List<AppointmentData>.from(json["data"]!.map((x) => AppointmentData.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    };
}

class AppointmentData {
    final int? id;
    final int? userId;
    final int? doctorId;
    final int? scheduleId;
    final String? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final Doctor? doctor;
    final Schedule? schedule;

    AppointmentData({
        this.id,
        this.userId,
        this.doctorId,
        this.scheduleId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.doctor,
        this.schedule,
    });

    factory AppointmentData.fromJson(String str) => AppointmentData.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AppointmentData.fromMap(Map<String, dynamic> json) => AppointmentData(
        id: json["id"],
        userId: json["user_id"],
        doctorId: json["doctor_id"],
        scheduleId: json["schedule_id"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        doctor: json["doctor"] == null ? null : Doctor.fromMap(json["doctor"]),
        schedule: json["schedule"] == null ? null : Schedule.fromMap(json["schedule"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "doctor_id": doctorId,
        "schedule_id": scheduleId,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "doctor": doctor?.toMap(),
        "schedule": schedule?.toMap(),
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
    final String? averageRating;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final User? user;

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
        averageRating: json["average_rating"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromMap(json["user"]),
    );

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
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class Schedule {
    final int? id;
    final int? doctorId;
    final DateTime? date;
    final String? day;
    final String? startTime;
    final String? endTime;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Schedule({
        this.id,
        this.doctorId,
        this.date,
        this.day,
        this.startTime,
        this.endTime,
        this.createdAt,
        this.updatedAt,
    });

    factory Schedule.fromJson(String str) => Schedule.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Schedule.fromMap(Map<String, dynamic> json) => Schedule(
        id: json["id"],
        doctorId: json["doctor_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        day: json["day"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "doctor_id": doctorId,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "day": day,
        "start_time": startTime,
        "end_time": endTime,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
