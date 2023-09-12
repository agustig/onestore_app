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
  final AuthGetToken _authGetToken;
  final AuthSaveToken _authSaveToken;
  final AuthRemoveToken _authRemoveToken;
  String? _currentToken;

  AuthBloc({
    required AuthLogin authLogin,
    required AuthRegister authRegister,
    required AuthLogout authLogout,
    required AuthGetToken authGetToken,
    required AuthSaveToken authSaveToken,
    required AuthRemoveToken authRemoveToken,
  })  : _authLogin = authLogin,
        _authRegister = authRegister,
        _authLogout = authLogout,
        _authGetToken = authGetToken,
        _authSaveToken = authSaveToken,
        _authRemoveToken = authRemoveToken,
        super(const _Initial()) {
    on<_GetStatus>(_onGetStatus);
    on<_Login>(_onLogin);
    on<_Register>(_onRegister);
    on<_Logout>(_onLogout);
  }

  Future<void> _refreshAuthStatus(Emitter<AuthState> emit) async {
    final result = await _authGetToken.execute();
    result.fold(
      (error) => emit(_Error(message: error.message)),
      (token) {
        _currentToken = token;
        emit((_currentToken != null)
            ? _Authenticated(_currentToken!)
            : const _Unauthenticated());
      },
    );
  }

  _onGetStatus(AuthEvent event, Emitter<AuthState> emit) async {
    emit(const _Loading());

    await _refreshAuthStatus(emit);
  }

  _onLogin(_Login event, Emitter<AuthState> emit) async {
    emit(const _Loading());

    try {
      final loginResult = await _authLogin.execute(
          email: event.email, password: event.password);
      loginResult.fold(
        (failure) => throw failure,
        (authData) => _currentToken = authData.token,
      );
      if (_currentToken != null) {
        final saveToken = await _authSaveToken.execute(_currentToken!);
        saveToken.fold(
          (failure) => throw failure,
          (_) => emit(const _Loaded('Login successfully')),
        );
      }

      await _refreshAuthStatus(emit);
    } on ValidatorFailure catch (failure) {
      emit(_Error(messages: failure.messages));
    } on Failure catch (failure) {
      emit(_Error(message: failure.message));
    }
  }

  _onRegister(_Register event, Emitter<AuthState> emit) async {
    emit(const _Loading());

    try {
      final registerResult = await _authRegister.execute(
        name: event.name,
        email: event.email,
        password: event.password,
        passwordConfirmation: event.passwordConfirmation,
      );
      registerResult.fold(
        (failure) => throw failure,
        (authData) => _currentToken = authData.token,
      );
      if (_currentToken != null) {
        final saveToken = await _authSaveToken.execute(_currentToken!);
        saveToken.fold(
          (failure) => throw failure,
          (success) => emit(const _Loaded('Register successfully')),
        );
      }

      await _refreshAuthStatus(emit);
    } on ValidatorFailure catch (failure) {
      emit(_Error(messages: failure.messages));
    } on Failure catch (failure) {
      emit(_Error(message: failure.message));
    }
  }

  _onLogout(_Logout event, Emitter<AuthState> emit) async {
    emit(const _Loading());
    try {
      late bool isLoggedOutFromRemote;

      if (_currentToken != null) {
        final logoutRemoteResult = await _authLogout.execute(_currentToken!);
        logoutRemoteResult.fold(
          (failure) => throw failure,
          (status) => isLoggedOutFromRemote = status,
        );

        if (isLoggedOutFromRemote) {
          final removeToken = await _authRemoveToken.execute();
          removeToken.fold(
            (failure) => throw failure,
            (_) => emit(const _Loaded('Logout successfully')),
          );
        }
      }

      await _refreshAuthStatus(emit);
    } on ValidatorFailure catch (failure) {
      emit(_Error(messages: failure.messages));
    } on Failure catch (failure) {
      emit(_Error(message: failure.message));
    }
  }
}
