part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.login({
    required String email,
    required String password,
  }) = _Login;
  const factory AuthEvent.register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) = _Register;
  const factory AuthEvent.logout() = _Logout;
  const factory AuthEvent.refresh() = _Refresh;
}
