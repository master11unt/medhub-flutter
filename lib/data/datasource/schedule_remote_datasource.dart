import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:medhub/constants/variable.dart';
import 'package:medhub/data/datasource/auth_local_datasource.dart';
import 'package:medhub/data/model/response/schedule_response_model.dart';

class ScheduleRemoteDatasource {
  final AuthLocalDatasource authLocalDatasource = AuthLocalDatasource();

  String getDoctorScheduleUrl(int doctorId) {
    return '${Variable.baseUrl}/api/schedules/doctor/$doctorId';
  }

  Future<Either<String, List<ScheduleResponse>>> getSchedulesByDoctorId(int doctorId) async {
    try {
      final authData = await authLocalDatasource.getAuthData();
      
      final url = getDoctorScheduleUrl(doctorId);
      
      debugPrint('=== SCHEDULE API REQUEST ===');
      debugPrint('URL: $url');
      debugPrint('Doctor ID: $doctorId');
      debugPrint('Token exists: ${authData.token != null}');
      
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${authData.token}',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Request timeout');
        },
      );

      debugPrint('=== SCHEDULE API RESPONSE [Doctor ID: $doctorId] ===');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body.substring(0, min(500, response.body.length))}...');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        
        // Check if we're getting schedules for the correct doctor ID
        final responseDocId = jsonResponse['doctor_id'];
        if (responseDocId != null && responseDocId.toString() != doctorId.toString()) {
          debugPrint('⚠️ WARNING: API returned doctor_id $responseDocId but we requested $doctorId');
        }
        
        // Cek status dari response
        if (jsonResponse['status'] == 'success') {
          final dynamic schedulesData = jsonResponse['data'];
          
          if (schedulesData == null) {
            debugPrint('⚠️ No schedules data for doctor $doctorId');
            return Right([]);
          }
          
          if (schedulesData is! List) {
            debugPrint('❌ Schedules data is not a List: ${schedulesData.runtimeType}');
            return Left('Invalid schedules data format');
          }
          
          final List<dynamic> schedulesList = schedulesData as List<dynamic>;
          debugPrint('📊 Raw schedules count: ${schedulesList.length}');
          
          if (schedulesList.isEmpty) {
            debugPrint('⚠️ Empty schedules list for doctor $doctorId');
            return Right([]);
          }

          // Parse schedules
          final List<ScheduleResponse> schedules = [];
          
          for (int i = 0; i < schedulesList.length; i++) {
            try {
              final item = schedulesList[i];

              if (item is! Map<String, dynamic>) {
                debugPrint('❌ Schedule item $i is not a Map: ${item.runtimeType}');
                continue;
              }

              // Skip jika doctor_id tidak sesuai
              if (item['doctor_id'] == null || item['doctor_id'].toString() != doctorId.toString()) {
                debugPrint('⚠️ Schedule item doctor_id mismatch: ${item['doctor_id']} vs $doctorId - Skipping');
                continue;
              }

              final schedule = ScheduleResponse.fromMap(item);
              debugPrint('✅ Parsed schedule: ID=${schedule.id}, Doctor ID=${schedule.doctorId}, Day=${schedule.day}');

              schedules.add(schedule);
            } catch (e, stackTrace) {
              debugPrint('❌ Error parsing schedule item $i: $e');
              debugPrint('Stack trace: $stackTrace');
            }
          }
          
          debugPrint('📋 Final schedules count for doctor $doctorId: ${schedules.length}');
          return Right(schedules);
        } else {
          // Status bukan success
          final message = jsonResponse['message'] ?? 'Unknown error';
          debugPrint('❌ API returned error status: $message');
          return Left(message);
        }
        
      } else if (response.statusCode == 404) {
        debugPrint('⚠️ 404: Schedule endpoint not found');
        return Right([]);
      } else if (response.statusCode == 401) {
        debugPrint('❌ 401: Unauthorized');
        return Left('Authentication failed. Please login again.');
      } else {
        debugPrint('❌ API Error: ${response.statusCode}');
        try {
          final errorBody = json.decode(response.body);
          return Left(errorBody['message'] ?? 'Server error: ${response.statusCode}');
        } catch (e) {
          return Left('Server error: ${response.statusCode}');
        }
      }
      
    } catch (e, stackTrace) {
      debugPrint('❌ Network Exception: $e');
      debugPrint('Stack trace: $stackTrace');
      
      if (e.toString().contains('SocketException')) {
        return Left('Tidak dapat terhubung ke server. Periksa koneksi internet Anda.');
      } else if (e.toString().contains('timeout')) {
        return Left('Koneksi timeout. Periksa koneksi internet Anda.');
      } else {
        return Left('Network error: $e');
      }
    }
  }

  Future<Either<String, bool>> testConnection() async {
    try {
      final authData = await authLocalDatasource.getAuthData();
      final testUrl = Variable.apiUrl('user');
      
      debugPrint('Testing connection to: $testUrl');
      
      final response = await http.get(
        Uri.parse(testUrl),
        headers: {
          'Authorization': 'Bearer ${authData.token}',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));
      
      debugPrint('Test connection status: ${response.statusCode}');
      return Right(response.statusCode == 200);
    } catch (e) {
      debugPrint('Test connection failed: $e');
      return Left(e.toString());
    }
  }
}