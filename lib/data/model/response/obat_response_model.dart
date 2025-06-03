import 'dart:convert';

class ObatResponModel {
  final bool? success;
  final String? message;
  final List<ObatRespon>? data;

  ObatResponModel({
    this.success,
    this.message,
    this.data,
  });

  factory ObatResponModel.fromJson(String str) =>
      ObatResponModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ObatResponModel.fromMap(Map<String, dynamic> json) =>
      ObatResponModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ObatRespon>.from(
                json["data"].map((x) => ObatRespon.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class ObatRespon {
  final int? id;
  final String? name;
  final String? price;
  final String? description;
  final String? composition;
  final String? packaging;
  final String? benefits;
  final String? category;
  final String? dose;
  final String? presentation;
  final String? storage;
  final String? attention;
  final String? sideEffects;
  final String? mimsStandardName;
  final String? registrationNumber;
  final String? drugClass;
  final Remarks? remarks;
  final String? reference;
  final String? k24Url;
  final bool? isPrescription;
  final String? image;
  final String? shareLink;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ObatRespon({
    this.id,
    this.name,
    this.price,
    this.description,
    this.composition,
    this.packaging,
    this.benefits,
    this.category,
    this.dose,
    this.presentation,
    this.storage,
    this.attention,
    this.sideEffects,
    this.mimsStandardName,
    this.registrationNumber,
    this.drugClass,
    this.remarks,
    this.reference,
    this.k24Url,
    this.isPrescription,
    this.image,
    this.shareLink,
    this.createdAt,
    this.updatedAt,
  });

  factory ObatRespon.fromJson(String str) =>
      ObatRespon.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ObatRespon.fromMap(Map<String, dynamic> json) => ObatRespon(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        composition: json["composition"],
        packaging: json["packaging"],
        benefits: json["benefits"],
        category: json["category"],
        dose: json["dose"],
        presentation: json["presentation"],
        storage: json["storage"],
        attention: json["attention"],
        sideEffects: json["side_effects"],
        mimsStandardName: json["mims_standard_name"],
        registrationNumber: json["registration_number"],
        drugClass: json["drug_class"],
        remarks: remarksValues.map[json["remarks"]],
        reference: json["reference"],
        k24Url: json["k24_url"],
        isPrescription: json["is_prescription"],
        image: json["image"],
        shareLink: json["share_link"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "composition": composition,
        "packaging": packaging,
        "benefits": benefits,
        "category": category,
        "dose": dose,
        "presentation": presentation,
        "storage": storage,
        "attention": attention,
        "side_effects": sideEffects,
        "mims_standard_name": mimsStandardName,
        "registration_number": registrationNumber,
        "drug_class": drugClass,
        "remarks": remarksValues.reverse[remarks],
        "reference": reference,
        "k24_url": k24Url,
        "is_prescription": isPrescription,
        "image": image,
        "share_link": shareLink,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

enum Remarks {
  TERAKHIR_DIPERBARUI_PADA_02_JUNI_2025,
  TERAKHIR_DIPERBARUI_PADA_19_APRIL_2025,
  TERAKHIR_DIPERBARUI_PADA_22_APRIL_2025
}

final remarksValues = EnumValues({
  "Terakhir diperbarui pada 02 Juni 2025":
      Remarks.TERAKHIR_DIPERBARUI_PADA_02_JUNI_2025,
  "Terakhir diperbarui pada 19 April 2025":
      Remarks.TERAKHIR_DIPERBARUI_PADA_19_APRIL_2025,
  "Terakhir diperbarui pada 22 April 2025":
      Remarks.TERAKHIR_DIPERBARUI_PADA_22_APRIL_2025
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}