part of 'edukasi_bloc.dart';

@freezed
class EdukasiState with _$EdukasiState {
  const factory EdukasiState.initial() = EdukasiStateInitial;
  const factory EdukasiState.loading() = EdukasiStateLoading;
  const factory EdukasiState.success(List<Edukasi> edukasi) = EdukasiStateSuccess;
  const factory EdukasiState.successDetail(Edukasi edukasi) = EdukasiStateSuccessDetail;
  const factory EdukasiState.error(String message) = EdukasiStateError;

}
