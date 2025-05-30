import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medhub/data/datasource/auth_local_datasource.dart';
import 'package:medhub/data/datasource/auth_remote_datasource.dart';
import 'package:medhub/data/model/request/register_request_model.dart';
import 'package:medhub/data/model/response/auth_response_model.dart';

part 'register_event.dart';
part 'register_state.dart';
part 'register_bloc.freezed.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRemoteDatasource datasource;

  RegisterBloc(this.datasource) : super(RegisterStateInitial()) {
    on<_Register>((event, emit) async {
      emit(RegisterStateLoading());
      final result = RegisterRequestModel(
        name: event.name,
        email: event.email,
        phone: event.phone,
        password: event.password,
        jenisKelamin: event.jenisKelamin,
        noKtp: event.noKtp,
      );

      final response = await datasource.register(result);

      await response.fold(
        (error) async {
          emit(RegisterStateError(error));
        },
        (data) async {
          await AuthLocalDatasource().saveAuthData(
            data,
          ); // <-- LETAKKAN DI SINI
          emit(RegisterStateSuccess(data));
        },
      );
    });
  }
}
