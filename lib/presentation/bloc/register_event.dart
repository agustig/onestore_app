part of 'register_bloc.dart';

@freezed
class RegisterEvent with _$RegisterEvent {
  const factory RegisterEvent.started() = _Started;
  const factory RegisterEvent.execute({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) = _Execute;
}
