part of 'logout_bloc.dart';

@freezed
class LogoutState with _$LogoutState {
  const factory LogoutState.initial() = LogoutStateInitial;
  const factory LogoutState.loading() = LogoutStateLoading;
  const factory LogoutState.success() = LogoutStateSuccess;
  const factory LogoutState.error(String message) = LogoutStateError;
}
