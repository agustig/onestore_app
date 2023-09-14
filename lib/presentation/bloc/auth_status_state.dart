part of 'auth_status_bloc.dart';

@freezed
class AuthStatusState with _$AuthStatusState {
  const factory AuthStatusState.loading() = _Loading;
  const factory AuthStatusState.error(String message) = _Error;
  const factory AuthStatusState.unauthenticated() = _Unauthenticated;
  const factory AuthStatusState.authenticated(String token) = _Authenticated;
}
