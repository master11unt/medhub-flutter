part of 'obat_bloc.dart';

@freezed
class ObatState with _$ObatState {
  const factory ObatState.initial() = _Initial;
  const factory ObatState.loading() = _Loading;
  const factory ObatState.success(List<ObatRespon> obat) = _Success;
  const factory ObatState.error(String message) = _Error;
}