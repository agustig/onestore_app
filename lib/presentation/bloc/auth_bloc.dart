import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_fic7/domain/usecases/auth_get_token.dart';
import 'package:flutter_store_fic7/domain/usecases/auth_login.dart';
import 'package:flutter_store_fic7/domain/usecases/auth_logout.dart';
import 'package:flutter_store_fic7/domain/usecases/auth_register.dart';
import 'package:flutter_store_fic7/domain/usecases/auth_remove_token.dart';
import 'package:flutter_store_fic7/domain/usecases/auth_save_token.dart';
import 'package:flutter_store_fic7/utils/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthLogin _authLogin;
  final AuthRegister _authRegister;
  final AuthLogout _authLogout;
  final AuthSaveToken _authSaveToken;
  final AuthRemoveToken _authRemoveToken;
  final AuthGetToken _authGetToken;

  AuthBloc({
    required AuthLogin authLogin,
    required AuthRegister authRegister,
    required AuthLogout authLogout,
    required AuthSaveToken authSaveToken,
    required AuthRemoveToken authRemoveToken,
    required AuthGetToken authGetToken,
  })  : _authLogin = authLogin,
        _authRegister = authRegister,
        _authLogout = authLogout,
        _authSaveToken = authSaveToken,
        _authRemoveToken = authRemoveToken,
        _authGetToken = authGetToken,
        super(const _Initial()) {
    on<_Login>(_onLogin);
    on<_Register>(_onRegister);
    on<_Logout>(_onLogout);
    on<_Refresh>((event, emit) => emit(const AuthState.initial()));
  }

  _onLogin(_Login event, Emitter<AuthState> emit) async {
    emit(const _Loading());

    try {
      late String currentToken;
      final loginResult = await _authLogin.execute(
          email: event.email, password: event.password);
      loginResult.fold(
        (failure) => throw failure,
        (authData) => currentToken = authData.token,
      );

      final saveToken = await _authSaveToken.execute(currentToken);
      saveToken.fold(
        (failure) => throw failure,
        (_) => emit(const _Loaded('Login successfully')),
      );
    } on ValidatorFailure catch (failure) {
      emit(_Error(messages: failure.messages));
    } on Failure catch (failure) {
      emit(_Error(message: failure.message));
    }
  }

  _onRegister(_Register event, Emitter<AuthState> emit) async {
    emit(const _Loading());

    try {
      late String currentToken;
      final registerResult = await _authRegister.execute(
        name: event.name,
        email: event.email,
        password: event.password,
        passwordConfirmation: event.passwordConfirmation,
      );
      registerResult.fold(
        (failure) => throw failure,
        (authData) => currentToken = authData.token,
      );

      final saveToken = await _authSaveToken.execute(currentToken);
      saveToken.fold(
        (failure) => throw failure,
        (success) => emit(const _Loaded('Register successfully')),
      );
    } on ValidatorFailure catch (failure) {
      emit(_Error(messages: failure.messages));
    } on Failure catch (failure) {
      emit(_Error(message: failure.message));
    }
  }

  _onLogout(_Logout event, Emitter<AuthState> emit) async {
    emit(const _Loading());
    try {
      bool isLoggedOutFromRemote = false;
      late String? authToken;

      final gettingToken = await _authGetToken.execute();
      gettingToken.fold(
        (failure) => throw failure,
        (token) => authToken = token,
      );

      if (authToken != null) {
        final logoutRemoteResult = await _authLogout.execute(authToken!);
        logoutRemoteResult.fold(
          (failure) => throw failure,
          (status) => isLoggedOutFromRemote = status,
        );
      }

      if (isLoggedOutFromRemote) {
        final removeToken = await _authRemoveToken.execute();
        removeToken.fold(
          (failure) => throw failure,
          (_) => emit(const _Loaded('Logout successfully')),
        );
      }
    } on Failure catch (failure) {
      emit(_Error(message: failure.message));
    }
  }
}
