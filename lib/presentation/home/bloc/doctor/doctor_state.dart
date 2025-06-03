import 'package:medhub/data/model/response/doctor_response_model.dart';

abstract class DoctorState {}

class DoctorInitial extends DoctorState {}

class DoctorLoading extends DoctorState {}

class DoctorLoaded extends DoctorState {
  final List<Doctor> doctors;
  
  DoctorLoaded(this.doctors);
}

class DoctorSingleLoaded extends DoctorState {
  final Doctor doctor; // Ubah tipe data dari DoctorResponseModel menjadi Doctor
  
  DoctorSingleLoaded(this.doctor);
}

class DoctorError extends DoctorState {
  final String message;
  
  DoctorError(this.message);
}