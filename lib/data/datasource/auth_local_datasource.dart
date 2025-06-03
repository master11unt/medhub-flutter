// biar data yg login kesimpen di penyimpanan hp
// pake shared preferences => penyimpanan lokal di hp atau penhyimpanan data kecil(token, sesi login)
// sifatnya presisten (tetep ada walaupun appliksi tertutup)

// import 'dart:ffi';

import 'dart:convert';

import 'package:medhub/data/model/response/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource {
  Future<void> saveAuthData(AuthResponseModel data) async {
    final pref = await SharedPreferences.getInstance();
    // data pengguna diubah jadi string json pake data.toJson
    // kenapa ke diubah ke string pake setString karena authResponsemodel itu bentuk objek, jd hrus diubah dlu menjadi string sblum disimpan
    // nanti auth_data digunakan untuk menyimpan string (data auth baru) dengan key auth_data
    await pref.setString('auth_data', data.toJson());
  }

  // remove data auth
  Future<void> removeAuthData() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('auth_data');
  }

  // get data auth
  Future<AuthResponseModel> getAuthData() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString('auth_data');
    if (data != null) {
      // data diubah kembali jadi objek
      return AuthResponseModel.fromJson(jsonDecode(data));
    } else {
      throw Exception('Data tidak ada');
    }
  }

  Future<String> getToken() async {
    try {
      final auth = await getAuthData();
      return auth.token ?? '';
    } catch (e) {
      return '';
    }
  }

  Future<String> getRefreshedToken() async {
    try {
      // This ensures we always get the latest token from storage
      final pref = await SharedPreferences.getInstance();
      final data = pref.getString('auth_data');
      if (data != null) {
        final authData = AuthResponseModel.fromJson(jsonDecode(data));
        return authData.token ?? '';
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  // Buat ngecek udah perna login atau belum
  Future<bool> isLogin() async {
    final pref = await SharedPreferences.getInstance();
    return pref.containsKey('auth_data');
  }
}
