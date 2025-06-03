part of 'edukasi_bloc.dart';

@freezed
class EdukasiEvent with _$EdukasiEvent {
  const factory EdukasiEvent.started() = _Started;
  const factory EdukasiEvent.fetch([String? kategori]) = _FetchEdukasi;
  const factory EdukasiEvent.fetchDetail(String id) = _FetchDetail;
  const factory EdukasiEvent.search(String query) = _SearchEdukasi;

}