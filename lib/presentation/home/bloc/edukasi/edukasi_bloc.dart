import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medhub/data/datasource/education_remote_datasource.dart';
import 'package:flutter/foundation.dart';
import 'package:medhub/data/model/response/edukasi_response_model.dart';

part 'edukasi_event.dart';
part 'edukasi_state.dart';
part 'edukasi_bloc.freezed.dart';

class EdukasiBloc extends Bloc<EdukasiEvent, EdukasiState> {
  final EdukasiRemoteDataSource remoteDatasource;

  EdukasiBloc(this.remoteDatasource) : super(const EdukasiState.initial()) {
    on<_FetchEdukasi>((event, emit) async {
      emit(const EdukasiState.loading());
      try {
        final data = await remoteDatasource.getEdukasiList(event.kategori);
        debugPrint("Fetched ${data.length} education items");
        if (data.isEmpty) {
          debugPrint("Warning: No education data returned");
        }
        emit(EdukasiState.success(data));
      } catch (e) {
        debugPrint("Error fetching education data: $e");
        emit(EdukasiState.error(e.toString()));
      }
    });

    on<_FetchDetail>((event, emit) async {
      emit(const EdukasiState.loading());
      try {
        final data = await remoteDatasource.getEdukasiDetail(event.id);
        if (data == null) {
          throw Exception("Detail tidak ditemukan");
        }
        emit(EdukasiState.successDetail(data));
      } catch (e) {
        debugPrint("Error fetching education detail: $e");
        emit(EdukasiState.error(e.toString()));
      }
    });

    on<_SearchEdukasi>((event, emit) async {
      emit(const EdukasiState.loading());
      try {
        if (event.query.trim().isEmpty) {
          // Jika query kosong, ambil semua data
          final data = await remoteDatasource.getEdukasiList("");
          emit(EdukasiState.success(data));
        } else {
          final data = await remoteDatasource.searchEdukasi(event.query);
          emit(EdukasiState.success(data));
        }
      } catch (e) {
        debugPrint("Error searching education data: $e");
        emit(EdukasiState.error(e.toString()));
      }
    });
  }
}