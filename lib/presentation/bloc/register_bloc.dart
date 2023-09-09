import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_fic7/domain/entities/auth.dart';
import 'package:flutter_store_fic7/domain/usecases/auth_register.dart';
import 'package:flutter_store_fic7/utils/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_event.dart';
part 'register_state.dart';
part 'register_bloc.freezed.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRegister _authRegister;

  RegisterBloc(AuthRegister authRegister)
      : _authRegister = authRegister,
        super(const _Initial()) {
    on<_Execute>((event, emit) async {
      emit(const _Loading());

      final result = await _authRegister.execute(
        name: event.name,
        email: event.email,
        password: event.password,
        passwordConfirmation: event.passwordConfirmation,
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
