import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_store_fic7/presentation/bloc/login_bloc.dart';
import 'package:flutter_store_fic7/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_object.dart';
import '../../mock_helper.dart';

void main() {
  late LoginBloc loginBloc;
  late MockAuthLogin mockUsecase;

  setUp(() {
    mockUsecase = MockAuthLogin();
    loginBloc = LoginBloc(mockUsecase);
  });

  const tAuth = testAuth;

  mockUsecaseCaller() => mockUsecase.execute(
        email: 'marlee.ledner@example.net',
        password: 'password',
      );

  const eventCaller = LoginEvent.execute(
    email: 'marlee.ledner@example.net',
    password: 'password',
  );

  const validatorMessages = {
    "email": ["The email field must be a valid email address."],
    "password": [
      "The password field must be at least 8 characters.",
      "The password field confirmation does not match."
    ]
  };

  test('initial setup should be initial state', () {
    expect(loginBloc.state, const LoginState.initial());
  });

  blocTest<LoginBloc, LoginState>(
    'should emit loading, and loaded on LoginState when execute is successfully',
    build: () {
      when(() => mockUsecaseCaller())
          .thenAnswer((_) async => const Right(tAuth));
      return loginBloc;
    },
    act: (bloc) => bloc.add(eventCaller),
    expect: () => [
      const LoginState.loading(),
      const LoginState.loaded(tAuth),
    ],
    verify: (_) => verify(() => mockUsecaseCaller()),
  );

  blocTest<LoginBloc, LoginState>(
    'should emit loading, and error with messages on LoginState when executor is error',
    build: () {
      when(() => mockUsecaseCaller()).thenAnswer(
        (_) async => const Left(ValidatorFailure(validatorMessages)),
      );
      return loginBloc;
    },
    act: (bloc) => bloc.add(eventCaller),
    expect: () => [
      const LoginState.loading(),
      const LoginState.error(messages: validatorMessages),
    ],
    verify: (_) => verify(() => mockUsecaseCaller()),
  );

  blocTest<LoginBloc, LoginState>(
    'should emit loading, and error on LoginState when executor has connection error',
    build: () {
      when(() => mockUsecaseCaller()).thenAnswer((_) async =>
          const Left(ConnectionFailure('Failed connect to the Network')));
      return loginBloc;
    },
    act: (bloc) => bloc.add(eventCaller),
    expect: () => [
      const LoginState.loading(),
      const LoginState.error(message: 'Failed connect to the Network'),
    ],
    verify: (_) => verify(() => mockUsecaseCaller()),
  );

  blocTest<LoginBloc, LoginState>(
    'should emit loading, and error on LoginState when executor is error',
    build: () {
      when(() => mockUsecaseCaller())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return loginBloc;
    },
    act: (bloc) => bloc.add(eventCaller),
    expect: () => [
      const LoginState.loading(),
      const LoginState.error(message: 'Server Failure'),
    ],
    verify: (_) => verify(() => mockUsecaseCaller()),
  );
}
