import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:medhub/constants/variable.dart';
import 'package:medhub/data/datasource/auth_local_datasource.dart';
import 'package:medhub/data/model/response/doctor_response_model.dart';

class DoctorRemoteDatasource {
  final AuthLocalDatasource authLocalDatasource = AuthLocalDatasource();

  Future<Either<String, List<Doctor>>> getDoctors() async {
    try {
      final authData = await authLocalDatasource.getAuthData();
      // Gunakan Variable.apiUrl untuk konstruksi URL yang benar
      final url = Variable.apiUrl('doctors'); // Bukan 'api-doctors'

      debugPrint('=== DOCTOR API REQUEST ===');
      debugPrint('URL: $url');
      debugPrint('Token exists: ${authData.token != null}');

      final response = await http
          .get(
            Uri.parse(url),
            headers: {
              'Authorization': 'Bearer ${authData.token}',
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
          )
          .timeout(
            const Duration(seconds: 30), // Tambahkan timeout
            onTimeout: () {
              throw Exception(
                'Request timeout - Check your internet connection',
              );
            },
          );

      debugPrint('=== DOCTOR API RESPONSE ===');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (!jsonResponse.containsKey('data')) {
          debugPrint('❌ Response missing data key');
          return Left('Invalid API response format');
        }

        final List<dynamic> doctorData = jsonResponse['data'] ?? [];
        debugPrint('📊 Doctors found: ${doctorData.length}');

        final List<Doctor> doctors =
            doctorData
                .map((json) => Doctor.fromMap(json as Map<String, dynamic>))
                .toList();

        return Right(doctors);
      } else if (response.statusCode == 404) {
        debugPrint('⚠️ 404: No doctors found');
        return Right([]);
      } else {
        debugPrint('❌ API Error: ${response.statusCode}');
        return Left('Server error: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      debugPrint('❌ Network Exception: $e');
      debugPrint('Stack trace: $stackTrace');

      // Handle specific error types
      if (e.toString().contains('SocketException')) {
        return Left(
          'Tidak dapat terhubung ke server. Periksa koneksi internet Anda.',
        );
      } else if (e.toString().contains('timeout')) {
        return Left('Koneksi timeout. Periksa koneksi internet Anda.');
      } else {
        return Left('Network error: $e');
      }
    }
  }

  Future<Either<String, Doctor>> getDoctorDetail(int doctorId) async {
    try {
      final authData = await authLocalDatasource.getAuthData();
      final response = await http.get(
        Uri.parse('${Variable.baseUrl}/doctors/$doctorId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authData.token}',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final doctor = Doctor.fromMap(data['data']);
        return Right(doctor);
      } else {
        return Left('Failed to load doctor details');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  // Tambahkan method ini ke DoctorRemoteDatasource
  Future<Either<String, List<Doctor>>> getTopDoctors() async {
    try {
      final result = await getDoctors();
      return result.fold((error) => Left(error), (doctors) {
        final sortedDoctors = List<Doctor>.from(doctors);
        sortedDoctors.sort((a, b) {
          final aRating = double.tryParse(a.averageRating ?? '0.0') ?? 0.0;
          final bRating = double.tryParse(b.averageRating ?? '0.0') ?? 0.0;
          return bRating.compareTo(aRating);
        });
        final topDoctors = sortedDoctors.take(5).toList();
        return Right(topDoctors);
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  // Method untuk pencarian
  Future<Either<String, List<Doctor>>> searchDoctors(String keyword) async {
    try {
      final result = await getDoctors();

      return result.fold((error) => Left(error), (doctors) {
        final filteredDoctors =
            doctors.where((doctor) {
              final name = doctor.user?.name?.toLowerCase() ?? '';
              final specialization = doctor.specialization?.toLowerCase() ?? '';
              final searchKeyword = keyword.toLowerCase();

              return name.contains(searchKeyword) ||
                  specialization.contains(searchKeyword);
            }).toList();

        return Right(filteredDoctors);
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  // Alias untuk getDoctorDetail
  Future<Either<String, Doctor>> getDoctorById(int id) async {
    try {
      final result = await getDoctorDetail(id);
      return result;
    } catch (e) {
      return Left(e.toString());
    }
  }

  // Tambahkan di DoctorRemoteDatasource
  Future<bool> testConnection() async {
    try {
      debugPrint('=== TESTING CONNECTION ===');
      debugPrint('Base URL: ${Variable.baseUrl}');

      // Test basic connectivity
      final response = await http
          .get(Uri.parse(Variable.baseUrl))
          .timeout(const Duration(seconds: 10));

      debugPrint('Connection test: ${response.statusCode}');
      return response.statusCode < 500;
    } catch (e) {
      debugPrint('Connection test failed: $e');
      return false;
    }
  }
}
