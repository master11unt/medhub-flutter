import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medhub/constants/variable.dart';
import 'package:medhub/data/model/request/health_record_request_model.dart';
import 'package:medhub/data/model/response/health_record_response_model.dart';

class HealthRecordRemoteDatasource {
  
  // Method untuk submit health record baru
  Future<HealthRecordResponseModel> submitHealthRecord(
    HealthRecordRequestModel data,
    String token,
  ) async {
    debugPrint('Submitting new health record');
    
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${Variable.baseUrl}/api/health-records'),
    );
    
    // Add headers
    request.headers.addAll({
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    
    // Add text fields
    if (data.height != null) {
      request.fields['height'] = data.height.toString();
    }
    if (data.weight != null) {
      request.fields['weight'] = data.weight.toString();
    }
    if (data.bloodType != null) {
      request.fields['blood_type'] = data.bloodType!;
    }
    if (data.birthDate != null) {
      request.fields['birth_date'] = data.birthDate!.toIso8601String().split('T').first;
    }
    if (data.age != null) {
      request.fields['age'] = data.age.toString();
    }
    if (data.allergies != null) {
      request.fields['allergies'] = data.allergies!;
    }
    if (data.currentMedications != null) {
      request.fields['current_medications'] = data.currentMedications!;
    }
    if (data.currentConditions != null) {
      request.fields['current_conditions'] = data.currentConditions!;
    }
    
    // Add file if exists
    if (data.medicalDocument != null && data.medicalDocument!.isNotEmpty) {
      File file = File(data.medicalDocument!);
      if (await file.exists()) {
        var multipartFile = await http.MultipartFile.fromPath(
          'medical_document',
          file.path,
        );
        request.files.add(multipartFile);
        debugPrint('File added: ${file.path}');
      }
    }
    
    debugPrint('Request fields: ${request.fields}');
    debugPrint('Request files: ${request.files.length}');
    
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    
    debugPrint('Submit response status: ${response.statusCode}');
    debugPrint('Submit response body: ${response.body}');
    
    if (response.statusCode == 200 || response.statusCode == 201) {
      return HealthRecordResponseModel.fromJson(response.body);
    } else {
      debugPrint('Submit error response: ${response.body}');
      if (response.headers['content-type']?.contains('application/json') == true) {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Gagal menyimpan data medis');
      } else {
        throw Exception('Server error: ${response.body}');
      }
    }
  }

  // Method untuk update health record
  Future<HealthRecordResponseModel> updateHealthRecord(
    int id,
    HealthRecordRequestModel data,
    String token,
  ) async {
    debugPrint('Updating health record ID: $id');
    
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${Variable.baseUrl}/api/health-records/$id'),
    );
    
    request.headers.addAll({
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    
    request.fields['_method'] = 'PUT';
    
    // Add text fields with proper null checks
    if (data.height != null) {
      request.fields['height'] = data.height.toString();
    }
    if (data.weight != null) {
      request.fields['weight'] = data.weight.toString();
    }
    if (data.bloodType != null && data.bloodType!.isNotEmpty) {
      request.fields['blood_type'] = data.bloodType!;
    }
    if (data.birthDate != null) {
      request.fields['birth_date'] = data.birthDate!.toIso8601String().split('T').first;
    }
    if (data.age != null) {
      request.fields['age'] = data.age.toString();
    }
    if (data.allergies != null && data.allergies!.isNotEmpty) {
      request.fields['allergies'] = data.allergies!;
    }
    if (data.currentMedications != null && data.currentMedications!.isNotEmpty) {
      request.fields['current_medications'] = data.currentMedications!;
    }
    if (data.currentConditions != null && data.currentConditions!.isNotEmpty) {
      request.fields['current_conditions'] = data.currentConditions!;
    }
    
    // Handle file upload
    if (data.medicalDocument != null && data.medicalDocument!.isNotEmpty) {
      if (!data.medicalDocument!.startsWith('http')) {
        File file = File(data.medicalDocument!);
        if (await file.exists()) {
          var multipartFile = await http.MultipartFile.fromPath(
            'medical_document',
            file.path,
          );
          request.files.add(multipartFile);
          debugPrint('New file added: ${file.path}');
        }
      } else {
        debugPrint('Keeping existing file: ${data.medicalDocument}');
      }
    }
    
    debugPrint('Update request fields: ${request.fields}');
    debugPrint('Update request files: ${request.files.length}');
    
    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      
      debugPrint('Update response status: ${response.statusCode}');
      debugPrint('Update response body: ${response.body}');
      
      if (response.statusCode == 200) {
        try {
          final responseModel = HealthRecordResponseModel.fromJson(response.body);
          debugPrint('✅ Response parsed successfully');
          return responseModel;
        } catch (parseError) {
          debugPrint('❌ Error parsing response: $parseError');
          debugPrint('Raw response: ${response.body}');
          throw Exception('Error parsing server response: $parseError');
        }
      } else {
        debugPrint('Update error response: ${response.body}');
        if (response.headers['content-type']?.contains('application/json') == true) {
          try {
            final errorData = jsonDecode(response.body);
            throw Exception(errorData['message'] ?? 'Gagal update data medis');
          } catch (e) {
            throw Exception('Server error: ${response.body}');
          }
        } else {
          throw Exception('Server error: ${response.body}');
        }
      }
    } catch (e) {
      debugPrint('❌ Network error: $e');
      throw Exception('Network error: $e');
    }
  }
  
  // Method untuk get health record (existing method, keep as is)
  Future<HealthRecordResponseModel> getHealthRecord(String token) async {
    final response = await http.get(
      Uri.parse('${Variable.baseUrl}/api/health-records'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    
    debugPrint('Get health record response: ${response.statusCode}');
    debugPrint('Get health record body: ${response.body}');
    
    if (response.statusCode == 200) {
      return HealthRecordResponseModel.fromJson(response.body);
    } else {
      if (response.headers['content-type']?.contains('application/json') == true) {
        throw Exception(
          jsonDecode(response.body)['message'] ?? 'Gagal memuat data medis',
        );
      } else {
        throw Exception('Server error: ${response.body}');
      }
    }
  }
}
