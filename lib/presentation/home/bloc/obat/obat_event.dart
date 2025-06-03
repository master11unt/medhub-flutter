part of 'obat_bloc.dart';

@freezed
class ObatEvent with _$ObatEvent {
  const factory ObatEvent.started() = _Started;
  const factory ObatEvent.fetch() = _FetchObat;
  const factory ObatEvent.search(String query) = _SearchObat;
}