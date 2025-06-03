import 'dart:convert';

class EdukasiCategoryResponse {
  final String? status;
  final List<EduCategory>? data;

  EdukasiCategoryResponse({this.status, this.data});

  factory EdukasiCategoryResponse.fromJson(String str) =>
      EdukasiCategoryResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EdukasiCategoryResponse.fromMap(Map<String, dynamic> json) =>
      EdukasiCategoryResponse(
        status: json["status"],
        data:
            json["data"] == null
                ? []
                : List<EduCategory>.from(
                  json["data"]!.map((x) => EduCategory.fromMap(x)),
                ),
      );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class EduCategory {
  final int? id;
  final String? name;
  final String? icon;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  EduCategory({this.id, this.name, this.icon, this.createdAt, this.updatedAt});

  factory EduCategory.fromJson(String str) =>
      EduCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EduCategory.fromMap(Map<String, dynamic> json) => EduCategory(
    id: json["id"],
    name: json["name"],
    icon: json["icon"],
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "icon": icon,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}