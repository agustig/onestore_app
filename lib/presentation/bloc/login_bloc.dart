import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_fic7/domain/entities/auth.dart';
import 'package:flutter_store_fic7/domain/usecases/auth_login.dart';
import 'package:flutter_store_fic7/utils/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthLogin _authLogin;
  LoginBloc(AuthLogin authLogin)
      : _authLogin = authLogin,
        super(const _Initial()) {
    on<_Execute>((event, emit) async {
      emit(const _Loading());

      final result = await _authLogin.execute(
        email: event.email,
        password: event.password,
      );
      result.fold(
        (error) => (error is ValidatorFailure)
            ? emit(_Error(messages: error.messages))
            : emit(_Error(message: error.message)),
        (data) => emit(_Loaded(data)),
      );
    });
  }
}
