import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:medhub/constants/variable.dart';
import 'package:medhub/data/datasource/auth_local_datasource.dart';
import 'package:medhub/data/model/response/obat_response_model.dart';

class ObatRemoteDatasource {
  final AuthLocalDatasource authLocalDatasource = AuthLocalDatasource();

  Future<Either<String, List<ObatRespon>>> getObat() async {
    try {
      final authData = await authLocalDatasource.getAuthData();
      final url = '${Variable.baseUrl}/api/obat';
      
      debugPrint('=== OBAT API REQUEST ===');
      debugPrint('URL: $url');
      debugPrint('Token exists: ${authData.token != null}');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${authData.token}',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      debugPrint('=== OBAT API RESPONSE ===');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        
        if (!jsonResponse.containsKey('data')) {
          debugPrint('❌ Response missing data key. Keys: ${jsonResponse.keys}');
          return Left('Invalid API response format');
        }

        final List<dynamic> obatData = jsonResponse['data'] ?? [];
        debugPrint('📊 Obat found: ${obatData.length}');
        
        if (obatData.isEmpty) {
          debugPrint('⚠️ No obat in database');
          return Right([]);
        }

        // Parse dan debug image URLs
        final List<ObatRespon> obatList = [];
        
        for (var i = 0; i < obatData.length; i++) {
          try {
            final item = obatData[i];
            debugPrint('Parsing obat item $i: $item');
            
            final obat = ObatRespon.fromMap(item as Map<String, dynamic>);
            debugPrint('✅ Parsed obat: ID=${obat.id}, Name=${obat.name}, Image=${obat.image}');
            
            obatList.add(obat);
          } catch (e) {
            debugPrint('❌ Error parsing obat item $i: $e');
          }
        }
        
        debugPrint('📋 Final obat count: ${obatList.length}');
        return Right(obatList);
        
      } else if (response.statusCode == 404) {
        debugPrint('⚠️ 404: No obat found');
        return Right([]);
      } else {
        debugPrint('❌ API Error: ${response.statusCode}');
        return Left('Server error: ${response.statusCode}');
      }
      
    } catch (e, stackTrace) {
      debugPrint('❌ Network Exception: $e');
      debugPrint('Stack trace: $stackTrace');
      return Left('Network error: $e');
    }
  }
}