part of 'register_bloc.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState.initial() = _Initial;
  const factory RegisterState.loading() = _Loading;
  const factory RegisterState.loaded(Auth authData) = _Loaded;
  const factory RegisterState.error({
    String? message,
    Map<String, List<String>>? messages,
  }) = _Error;
}
