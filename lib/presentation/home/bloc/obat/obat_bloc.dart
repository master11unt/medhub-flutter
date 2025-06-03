import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';
import 'package:medhub/data/datasource/obat_remote_datasource.dart';
import 'package:medhub/data/model/response/obat_response_model.dart';

part 'obat_event.dart';
part 'obat_state.dart';
part 'obat_bloc.freezed.dart';

class ObatBloc extends Bloc<ObatEvent, ObatState> {
  final ObatRemoteDatasource remoteDatasource;

  ObatBloc(this.remoteDatasource) : super(const ObatState.initial()) {
    on<ObatEvent>((event, emit) async {
      if (event.runtimeType.toString().contains('_Fetch')) {
        emit(const ObatState.loading());

        debugPrint('=== OBAT BLOC FETCHING ===');

        try {
          final result = await remoteDatasource.getObat();

          result.fold(
            (error) {
              debugPrint('❌ Obat fetch error: $error');
              emit(ObatState.error(error));
            },
            (obatList) {
              debugPrint('✅ Obat fetch success: ${obatList.length} items');

              // Debug image URLs
              for (var obat in obatList) {
                debugPrint('Obat: ${obat.name}, Image: ${obat.image}');
              }

              emit(ObatState.success(obatList));
            },
          );
        } catch (e) {
          debugPrint('❌ Obat bloc exception: $e');
          emit(ObatState.error(e.toString()));
        }
      }
    });
  }
}