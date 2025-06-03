import 'dart:convert';

class ScheduleResponseModel {
    final String? status;
    final List<ScheduleResponse>? data;
    final String? message;
    final String? doctorId;

    ScheduleResponseModel({
        this.status,
        this.data,
        this.message,
        this.doctorId,
    });

    factory ScheduleResponseModel.fromJson(String str) => ScheduleResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ScheduleResponseModel.fromMap(Map<String, dynamic> json) => ScheduleResponseModel(
        status: json["status"],
        data: json["data"] == null ? [] : List<ScheduleResponse>.from(json["data"]!.map((x) => ScheduleResponse.fromMap(x))),
        message: json["message"],
        doctorId: json["doctor_id"],
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "message": message,
        "doctor_id": doctorId,
    };
}

class ScheduleResponse {
    final int? id;
    final int? doctorId;
    final DateTime? date;
    final String? day;
    final String? startTime;
    final String? endTime;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    ScheduleResponse({
        this.id,
        this.doctorId,
        this.date,
        this.day,
        this.startTime,
        this.endTime,
        this.createdAt,
        this.updatedAt,
    });

    factory ScheduleResponse.fromJson(String str) => ScheduleResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ScheduleResponse.fromMap(Map<String, dynamic> json) => ScheduleResponse(
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
