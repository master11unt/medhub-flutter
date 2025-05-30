import 'dart:convert';

class AuthResponseModel {
  final User? user;
  final String? token;

  AuthResponseModel({this.user, this.token});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
    AuthResponseModel(
      user: json["user"] == null ? null : User.fromMap(json["user"]),
      token: json["token"],
    );

  String toJson() => json.encode(toMap());

  factory AuthResponseModel.fromMap(Map<String, dynamic> json) =>
      AuthResponseModel(
        user: json["user"] == null ? null : User.fromMap(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toMap() => {"user": user?.toMap(), "token": token};
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? role;
  final String? jenisKelamin;
  final String? noKtp;
  final dynamic image;
  final dynamic emailVerifiedAt;
  final dynamic createdAt;
  final dynamic updatedAt;

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
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
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
    "created_at": createdAt,
    "updated_at": updatedAt,
  };

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? role,
    String? jenisKelamin,
    String? noKtp,
    dynamic image,
    dynamic emailVerifiedAt,
    dynamic createdAt,
    dynamic updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      jenisKelamin: jenisKelamin ?? this.jenisKelamin,
      noKtp: noKtp ?? this.noKtp,
      image: image ?? this.image,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
