import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:medhub/constants/variable.dart';
import 'package:medhub/data/model/response/doctor_response_model.dart';

class DoctorRemoteDatasource {
  Future<Either<String, List<Doctor>>> getDoctors() async {
    try {
      final response = await http.get(
        Uri.parse('${Variable.baseUrl}/api/api-doctors'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final doctorResponse = DoctorResponseModel.fromMap(data);
        return Right(doctorResponse.data ?? []);
      } else {
        return Left('Failed to load doctors');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
