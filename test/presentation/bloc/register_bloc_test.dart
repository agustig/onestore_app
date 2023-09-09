import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_store_fic7/presentation/bloc/register_bloc.dart';
import 'package:flutter_store_fic7/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_object.dart';
import '../../mock_helper.dart';

void main() {
  late RegisterBloc registerBloc;
  late MockAuthRegister mockUsecase;

  setUp(() {
    mockUsecase = MockAuthRegister();
    registerBloc = RegisterBloc(mockUsecase);
  });

  const tAuth = testAuth;

  mockUsecaseCaller() => mockUsecase.execute(
        name: 'Mr. Manuela Zboncak III',
        email: 'marlee.ledner@example.net',
        password: 'password',
        passwordConfirmation: 'password',
      );

  const eventCaller = RegisterEvent.execute(
    name: 'Mr. Manuela Zboncak III',
    email: 'marlee.ledner@example.net',
    password: 'password',
    passwordConfirmation: 'password',
  );

  const validatorMessages = {
    "email": ["The email field must be a valid email address."],
    "password": [
      "The password field must be at least 8 characters.",
      "The password field confirmation does not match."
    ]
  };

  test('initial setup should be initial state', () {
    expect(registerBloc.state, const RegisterState.initial());
  });

  blocTest<RegisterBloc, RegisterState>(
    'should emit loading, and loaded on RegisterState when execute is successfully',
    build: () {
      when(() => mockUsecaseCaller())
          .thenAnswer((_) async => const Right(tAuth));
      return registerBloc;
    },
    act: (bloc) => bloc.add(eventCaller),
    expect: () => [
      const RegisterState.loading(),
      const RegisterState.loaded(tAuth),
    ],
    verify: (_) => verify(() => mockUsecaseCaller()),
  );

  blocTest<RegisterBloc, RegisterState>(
    'should emit loading, and error with messages on RegisterState when executor is error',
    build: () {
      when(() => mockUsecaseCaller()).thenAnswer(
        (_) async => const Left(ValidatorFailure(validatorMessages)),
      );
      return registerBloc;
    },
    act: (bloc) => bloc.add(eventCaller),
    expect: () => [
      const RegisterState.loading(),
      const RegisterState.error(messages: validatorMessages),
    ],
    verify: (_) => verify(() => mockUsecaseCaller()),
  );

  blocTest<RegisterBloc, RegisterState>(
    'should emit loading, and error on RegisterState when executor has connection error',
    build: () {
      when(() => mockUsecaseCaller()).thenAnswer((_) async =>
          const Left(ConnectionFailure('Failed connect to the Network')));
      return registerBloc;
    },
    act: (bloc) => bloc.add(eventCaller),
    expect: () => [
      const RegisterState.loading(),
      const RegisterState.error(message: 'Failed connect to the Network'),
    ],
    verify: (_) => verify(() => mockUsecaseCaller()),
  );

  blocTest<RegisterBloc, RegisterState>(
    'should emit loading, and error on RegisterState when executor is error',
    build: () {
      when(() => mockUsecaseCaller())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return registerBloc;
    },
    act: (bloc) => bloc.add(eventCaller),
    expect: () => [
      const RegisterState.loading(),
      const RegisterState.error(message: 'Server Failure'),
    ],
    verify: (_) => verify(() => mockUsecaseCaller()),
  );
}
