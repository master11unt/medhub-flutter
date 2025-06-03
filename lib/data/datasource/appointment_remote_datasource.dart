import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:medhub/constants/variable.dart';
import 'package:medhub/data/datasource/auth_local_datasource.dart';
import 'package:medhub/data/model/response/appointment_response_model.dart';

class AppointmentRemoteDatasource {
  final AuthLocalDatasource authLocalDatasource = AuthLocalDatasource();

  Future<Either<String, dynamic>> createAppointment({
    required int doctorId,
    required int scheduleId,
    required String complaint,
  }) async {
    try {
      final authData = await authLocalDatasource.getAuthData();

      // Debug info
      debugPrint('Creating appointment with:');
      debugPrint('- Doctor ID: $doctorId');
      debugPrint('- Schedule ID: $scheduleId');
      debugPrint('- Complaint: $complaint');

      final response = await http.post(
        Uri.parse('${Variable.baseUrl}/api/appointments'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        },
        body: jsonEncode({
          'doctor_id': doctorId,
          'schedule_id': scheduleId,
          'complaint': complaint,
        }),
      );

      // Debug response
      debugPrint('API Response Status: ${response.statusCode}');
      debugPrint('API Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return Right(data);
      } else {
        // Coba parse error message
        try {
          final data = jsonDecode(response.body);
          final errorMessage = data['message'] ?? 'Gagal membuat janji';
          return Left(errorMessage);
        } catch (e) {
          // Fallback jika gagal parse JSON
          return Left('Gagal membuat janji: ${response.statusCode}');
        }
      }
    } catch (e) {
      debugPrint('Exception in createAppointment: $e');
      return Left(e.toString());
    }
  }

  Future<Either<String, List<AppointmentData>>> getAppointments() async {
    try {
      final authData = await authLocalDatasource.getAuthData();

      final response = await http.get(
        Uri.parse('${Variable.baseUrl}/api/appointments'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> dataList = data['data'] ?? [];
        final appointments =
            dataList.map((item) => AppointmentData.fromMap(item)).toList();

        return Right(appointments);
      } else {
        final data = jsonDecode(response.body);
        return Left(data['message'] ?? 'Gagal mengambil data jadwal');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
