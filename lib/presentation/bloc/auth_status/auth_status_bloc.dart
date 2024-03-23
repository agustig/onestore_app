import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onestore_app/domain/usecases/auth/auth_get_token.dart';
import 'package:onestore_app/utils/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_status_event.dart';
part 'auth_status_state.dart';
part 'auth_status_bloc.freezed.dart';

class AuthStatusBloc extends Bloc<AuthStatusEvent, AuthStatusState> {
  final AuthGetToken _authGetToken;

  AuthStatusBloc(AuthGetToken authGetToken)
      : _authGetToken = authGetToken,
        super(const _Unauthenticated()) {
    on<_Check>((event, emit) async {
      emit(const _Loading());
      try {
        final result = await _authGetToken.execute();
        result.fold(
            (failure) => throw failure,
            (token) => emit((token != null)
                ? _Authenticated(token)
                : const _Unauthenticated()));
      } on Failure catch (failure) {
        emit(_Error(failure.message));
      }
    });
  }
}
