import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medhub/constants/variable.dart';
import 'package:medhub/data/model/request/health_record_request_model.dart';
import 'package:medhub/data/model/response/health_record_response_model.dart';

class HealthRecordRemoteDatasource {
  Future<HealthRecordResponseModel> submitHealthRecord(
    HealthRecordRequestModel data,
    String token,
  ) async {
    print('URL: ${Variable.baseUrl}/api/health-records');
    print('Token: $token');
    print('Body: ${jsonEncode(data.toJson())}');

    final response = await http.post(
      Uri.parse('${Variable.baseUrl}/api/health-records'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data.toJson()),
    );
    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      return HealthRecordResponseModel.fromJson(
        jsonDecode(response.body)['data'],
      );
    } else {
      print('Error response: ${response.body}');
      if (response.headers['content-type']?.contains('application/json') ==
          true) {
        throw Exception(
          jsonDecode(response.body)['message'] ?? 'Gagal menyimpan data medis',
        );
      } else {
        throw Exception('Server error: ${response.body}');
      }
    }
  }

  Future<HealthRecordResponseModel> updateHealthRecord(
    int id,
    HealthRecordRequestModel data,
    String token,
  ) async {
    final response = await http.put(
      Uri.parse('${Variable.baseUrl}/api/health-records/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data.toJson()),
    );
    if (response.statusCode == 200) {
      return HealthRecordResponseModel.fromJson(
        jsonDecode(response.body)['data'],
      );
    } else {
      throw Exception(
        jsonDecode(response.body)['message'] ?? 'Gagal update data medis',
      );
    }
  }

  Future<HealthRecordResponseModel> getMyHealthRecord(String token) async {
    final response = await http.get(
      Uri.parse('${Variable.baseUrl}/api/health-records/me'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return HealthRecordResponseModel.fromJson(response.body);
    } else {
      throw Exception(
        jsonDecode(response.body)['message'] ?? 'Gagal mengambil data medis',
      );
    }
  }
}
