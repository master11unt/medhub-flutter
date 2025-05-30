import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:dartz/dartz.dart';
import 'package:medhub/constants/variable.dart';
import 'package:medhub/data/datasource/auth_local_datasource.dart';
import 'package:medhub/data/model/request/login_request_model.dart';
import 'package:medhub/data/model/request/register_request_model.dart';
import 'package:medhub/data/model/response/auth_response_model.dart';

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
    LoginRequestModel data,
  ) async {
    // ngirim permintaan post ke server untuk login
    final response = await http.post(
      Uri.parse('${Variable.baseUrl}/api/login'),
      // header buat atur format data yg dikirim agar server ngenalin kalau ini permintaan dr json
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      // ubah loginRequestModel jd format json sblum dikirim
      body: data.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(jsonDecode(response.body)));
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, AuthResponseModel>> register(
    RegisterRequestModel data,
  ) async {
    print('Register data : $data.toJson()');
    try {
      final response = await http.post(
        Uri.parse('${Variable.baseUrl}/api/register'),
        headers: <String, String>{
          'Accept': 'application/json; charset=UTF-8',
          'Content-Type': 'application/json',
        },
        body: data.toJson(),
      );

      print('Register response : ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(AuthResponseModel.fromJson(jsonDecode(response.body)));
      } else {
        return Left(response.body);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  // Logout
  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variable.baseUrl}/api/logout'),
      headers: <String, String>{
        'Authorization': 'Bearer ${authData.token}',
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return Right('Logout berhasil');
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, AuthResponseModel>> updateProfileImage(
    File imageFile,
  ) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final url = Uri.parse('${Variable.baseUrl}/api/update-profile-image');
      // membuat request multipart untuk mengirim file gbr
      var request = http.MultipartRequest('POST', url);

      request.headers.addAll({
        'Authorization': 'Bearer ${authData.token}',
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': 'application/json',
      });

      var multipartFile = await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
      );
      request.files.add(multipartFile);

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final authResponse = AuthResponseModel.fromMap({
          'user': jsonResponse['data'],
          'token': authData.token,
        });
        return Right(authResponse);
      } else {
        print('Gagal mengunggah gambar : ${response.statusCode}');
        print('response body : ${response.body}');
        return Left(response.body);
      }
    } catch (e) {
      print('error : $e');
      return Left(e.toString());
    }
  }

  Future<AuthResponseModel> updateUserProfile({
    required String token,
    required String name,
    required String email,
    required String phone,
    required String jenisKelamin,
    required String noKtp,
    String? password, // tambahkan parameter password nullable
  }) async {
    final Map<String, dynamic> body = {
      'name': name,
      'email': email,
      'phone': phone,
      'jenis_kelamin': jenisKelamin,
      'no_ktp': noKtp,
    };
    if (password != null && password.isNotEmpty) {
      body['password'] = password;
    }

    final response = await http.put(
      Uri.parse('${Variable.baseUrl}/api/update-profile'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(body),
    );

    print('Update profile response: ${response.body}');

    if (response.statusCode == 200) {
      return AuthResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal update profil: ${response.body}');
    }
  }
}
