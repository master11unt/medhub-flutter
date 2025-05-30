import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medhub/data/datasource/auth_remote_datasource.dart';

part 'logout_event.dart';
part 'logout_state.dart';
part 'logout_bloc.freezed.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthRemoteDatasource _authRemoteDatasource;
  LogoutBloc(
    this._authRemoteDatasource,
  ) : super(LogoutStateInitial()) {
    on<_Logout>((event, emit) async {
      emit(LogoutStateLoading()); 
      final result = await _authRemoteDatasource.logout();

      result.fold(
        (error) => emit(LogoutStateError(error)),
        (data) => emit(LogoutStateSuccess()),
      );
    });
  }
}
