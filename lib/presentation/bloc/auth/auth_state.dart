part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.loaded(String authMessage) = _Loaded;
  const factory AuthState.error({
    String? message,
    Map<String, List<String>>? messages,
  }) = _Error;
}
