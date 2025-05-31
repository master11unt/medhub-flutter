import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medhub/data/datasource/auth_remote_datasource.dart';
import 'package:medhub/data/model/request/login_request_model.dart';
import 'package:medhub/data/model/response/auth_response_model.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDatasource datasource;

  LoginBloc(this.datasource) : super(const LoginState.initial()) {
    on<_Login>((event, emit) async {
      emit(const LoginState.loading());

      final result = await datasource.login(
        LoginRequestModel(email: event.email, password: event.password),
      );

      result.fold(
        (error) => emit(LoginState.error(error)),
        (data) => emit(LoginState.success(data)),
      );
    });
  }
}
