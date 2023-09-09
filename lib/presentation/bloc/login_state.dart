part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading() = _Loading;
  const factory LoginState.loaded(Auth authData) = _Loaded;
  const factory LoginState.error({
    String? message,
    Map<String, List<String>>? messages,
  }) = _Error;
}
