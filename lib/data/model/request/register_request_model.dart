import 'dart:convert';

class RegisterRequestModel {
    final String name;
    final String email;
    final String password;
    final String phone;
    final String jenisKelamin;
    final String noKtp;

    RegisterRequestModel({
        required this.name,
        required this.email,
        required this.password,
        required this.phone,
        required this.jenisKelamin,
        required this.noKtp,
    });

    factory RegisterRequestModel.fromJson(String str) => RegisterRequestModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RegisterRequestModel.fromMap(Map<String, dynamic> json) => RegisterRequestModel(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        jenisKelamin: json["jenis_kelamin"],
        noKtp: json["no_ktp"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "jenis_kelamin": jenisKelamin,
        "no_ktp": noKtp,
    };
}
