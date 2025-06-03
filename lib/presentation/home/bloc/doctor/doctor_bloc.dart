import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medhub/data/datasource/doctor_remote_datasource.dart';
import 'package:medhub/data/model/response/doctor_response_model.dart';
import 'package:medhub/presentation/home/bloc/doctor/doctor_event.dart';
import 'package:medhub/presentation/home/bloc/doctor/doctor_state.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final DoctorRemoteDatasource datasource;
  
  DoctorBloc(this.datasource) : super(DoctorInitial()) {
    on<DoctorFetchAll>((event, emit) async {
      emit(DoctorLoading());
      
      try {
        final result = await datasource.getDoctors();
        
        result.fold(
          (error) => emit(DoctorError(error)),
          (doctors) => emit(DoctorLoaded(doctors))
        );
      } catch (e) {
        emit(DoctorError(e.toString()));
      }
    });
    
    on<DoctorFetchTop>((event, emit) async {
      emit(DoctorLoading());
      
      try {
        final result = await datasource.getDoctors();
        
        result.fold(
          (error) => emit(DoctorError(error)),
          (doctors) {
            final sortedDoctors = List<Doctor>.from(doctors)
              ..sort((a, b) {
                final aRating = a.averageRating is String 
                    ? double.tryParse(a.averageRating ?? '0.0') ?? 0.0
                    : (a.averageRating ?? 0.0).toDouble();
                
                final bRating = b.averageRating is String 
                    ? double.tryParse(b.averageRating ?? '0.0') ?? 0.0
                    : (b.averageRating ?? 0.0).toDouble();
                
                return bRating.compareTo(aRating);
              });
            
            final topDoctors = sortedDoctors.take(5).toList();
            emit(DoctorLoaded(topDoctors));
          }
        );
      } catch (e) {
        emit(DoctorError(e.toString()));
      }
    });
    
    on<DoctorSearch>((event, emit) async {
      emit(DoctorLoading());
      
      try {
        final result = await datasource.getDoctors();
        
        result.fold(
          (error) => emit(DoctorError(error)),
          (doctors) {
            final filteredDoctors = doctors.where((doctor) {
              final name = doctor.user?.name?.toLowerCase() ?? '';
              final specialization = doctor.specialization?.toLowerCase() ?? '';
              final keyword = event.keyword.toLowerCase();
              
              return name.contains(keyword) || specialization.contains(keyword);
            }).toList();
            
            emit(DoctorLoaded(filteredDoctors));
          }
        );
      } catch (e) {
        emit(DoctorError(e.toString()));
      }
    });
    
    on<DoctorFetchById>((event, emit) async {
      emit(DoctorLoading());
      
      try {
        final result = await datasource.getDoctorDetail(event.id);
        
        result.fold(
          (error) => emit(DoctorError(error)),
          (doctor) => emit(DoctorSingleLoaded(doctor))
        );
      } catch (e) {
        emit(DoctorError(e.toString()));
      }
    });
  }
}