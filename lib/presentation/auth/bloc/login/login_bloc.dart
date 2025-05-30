import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medhub/data/datasource/auth_local_datasource.dart';
import 'package:medhub/data/datasource/auth_remote_datasource.dart';
import 'package:medhub/data/model/request/login_request_model.dart';
import 'package:medhub/data/model/response/auth_response_model.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  // bikin fungsi yang dipakai untuk menghubungkan api login backend
  // berarti dengan kode itu, kita pangggil api login ke server
  final AuthRemoteDatasource authRemoteDatasource;
  LoginBloc(
    this.authRemoteDatasource,
    // _Initial itu artinya belum ada proses login yang jalan
  ) : super(LoginStateInitial()) {
    // nanti kode ini akan menjalankan logika saat event _login dipanggil
    // event _login jalan berartikan user klik tombol login dan bawa data email dan password
    on<_Login>((event, emit) async {
      emit(LoginStateLoading());
      final dataRequest = LoginRequestModel(
        email: event.email,
        password: event.password,
      );
      final response = await authRemoteDatasource.login(dataRequest);
      await response.fold(
        (error) async {
          emit(LoginStateError(error));
        },
        (data) async {
          await AuthLocalDatasource().saveAuthData(data);
          emit(LoginStateSuccess(data));
        },
      );
    });
  }
}
