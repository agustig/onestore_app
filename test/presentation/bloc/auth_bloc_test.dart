import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_store_fic7/presentation/bloc/auth_bloc.dart';
import 'package:flutter_store_fic7/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_object.dart';
import '../../mock_helper.dart';

void main() {
  late AuthBloc authBloc;
  late MockAuthLogin mockAuthLogin;
  late MockAuthRegister mockAuthRegister;
  late MockAuthLogout mockAuthLogout;
  late MockAuthGetToken mockAuthGetToken;
  late MockAuthRemoveToken mockAuthRemoveToken;
  late MockAuthSaveToken mockAuthSaveToken;

  setUp(() {
    mockAuthLogin = MockAuthLogin();
    mockAuthRegister = MockAuthRegister();
    mockAuthLogout = MockAuthLogout();
    mockAuthGetToken = MockAuthGetToken();
    mockAuthRemoveToken = MockAuthRemoveToken();
    mockAuthSaveToken = MockAuthSaveToken();

    authBloc = AuthBloc(
      authLogin: mockAuthLogin,
      authRegister: mockAuthRegister,
      authLogout: mockAuthLogout,
      authGetToken: mockAuthGetToken,
      authRemoveToken: mockAuthRemoveToken,
      authSaveToken: mockAuthSaveToken,
    );
  });

  const tAuth = testAuth;
  final tAuthToken = tAuth.token;

  test('initial setup should be initial state', () {
    expect(authBloc.state, const AuthState.initial());
  });

  group('AuthEvent.getStatus():', () {
    mockTokenCheckCaller() => mockAuthGetToken.execute();

    const eventCaller = AuthEvent.getStatus();

    blocTest<AuthBloc, AuthState>(
      'should emit [loading, authenticated] on AuthState when execute is successfully',
      build: () {
        when(() => mockTokenCheckCaller())
            .thenAnswer((_) async => Right(tAuthToken));
        return authBloc;
      },
      act: (bloc) => bloc.add(eventCaller),
      expect: () => [
        const AuthState.loading(),
        AuthState.authenticated(tAuthToken),
      ],
      verify: (_) {
        verify(() => mockTokenCheckCaller());
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [Loading, error] on AuthState when database is error',
      build: () {
        when(() => mockTokenCheckCaller()).thenAnswer(
            (_) async => const Left(DatabaseFailure('Database failure')));
        return authBloc;
      },
      act: (bloc) => bloc.add(eventCaller),
      expect: () => [
        const AuthState.loading(),
        const AuthState.error(message: 'Database failure'),
      ],
      verify: (_) {
        verify(() => mockTokenCheckCaller());
      },
    );
  });

  group('AuthEvent.login():', () {
    mockLoginUsecaseCaller() => mockAuthLogin.execute(
          email: 'marlee.ledner@example.net',
          password: 'password',
        );
    mockSaveTokenUsecaseCaller() => mockAuthSaveToken.execute(tAuthToken);
    mockCheckTokenUsecaseCaller() => mockAuthGetToken.execute();

    const eventCaller = AuthEvent.login(
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

    blocTest<AuthBloc, AuthState>(
      'should emit [loading, loaded, authenticated] on AuthState when execute is successfully',
      build: () {
        when(() => mockLoginUsecaseCaller())
            .thenAnswer((_) async => const Right(tAuth));
        when(() => mockSaveTokenUsecaseCaller())
            .thenAnswer((_) async => const Right(true));
        when(() => mockCheckTokenUsecaseCaller())
            .thenAnswer((_) async => Right(tAuthToken));
        return authBloc;
      },
      act: (bloc) => bloc.add(eventCaller),
      expect: () => [
        const AuthState.loading(),
        const AuthState.loaded('Login successfully'),
        AuthState.authenticated(tAuthToken),
      ],
      verify: (_) {
        verify(() => mockLoginUsecaseCaller());
        verify(() => mockSaveTokenUsecaseCaller());
        verify(() => mockCheckTokenUsecaseCaller());
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [loading, error] with messages on AuthState when executor is error',
      build: () {
        when(() => mockLoginUsecaseCaller()).thenAnswer(
          (_) async => const Left(ValidatorFailure(validatorMessages)),
        );
        return authBloc;
      },
      act: (bloc) => bloc.add(eventCaller),
      expect: () => [
        const AuthState.loading(),
        const AuthState.error(messages: validatorMessages),
      ],
      verify: (_) {
        verify(() => mockLoginUsecaseCaller());
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [loading, error] on AuthState when executor has connection error',
      build: () {
        when(() => mockLoginUsecaseCaller()).thenAnswer((_) async =>
            const Left(ConnectionFailure('Failed connect to the Network')));
        return authBloc;
      },
      act: (bloc) => bloc.add(eventCaller),
      expect: () => [
        const AuthState.loading(),
        const AuthState.error(message: 'Failed connect to the Network'),
      ],
      verify: (_) {
        verify(() => mockLoginUsecaseCaller());
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [Loading, error] on AuthState when executor is error',
      build: () {
        when(() => mockLoginUsecaseCaller()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return authBloc;
      },
      act: (bloc) => bloc.add(eventCaller),
      expect: () => [
        const AuthState.loading(),
        const AuthState.error(message: 'Server Failure'),
      ],
      verify: (_) {
        verify(() => mockLoginUsecaseCaller());
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [Loading, error] on AuthState when database is error',
      build: () {
        when(() => mockLoginUsecaseCaller())
            .thenAnswer((_) async => const Right(tAuth));
        when(() => mockSaveTokenUsecaseCaller()).thenAnswer(
            (_) async => const Left(DatabaseFailure('Database failure')));
        return authBloc;
      },
      act: (bloc) => bloc.add(eventCaller),
      expect: () => [
        const AuthState.loading(),
        const AuthState.error(message: 'Database failure'),
      ],
      verify: (_) {
        verify(() => mockLoginUsecaseCaller());
        verify(() => mockSaveTokenUsecaseCaller());
      },
    );
  });

  group('AuthEvent.register():', () {
    mockRegisterUsecaseCaller() => mockAuthRegister.execute(
          name: 'Mr. Manuela Zboncak III',
          email: 'marlee.ledner@example.net',
          password: 'password',
          passwordConfirmation: 'password',
        );
    mockSaveTokenUsecaseCaller() => mockAuthSaveToken.execute(tAuthToken);
    mockCheckTokenUsecaseCaller() => mockAuthGetToken.execute();

    const eventCaller = AuthEvent.register(
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

    blocTest<AuthBloc, AuthState>(
      'should emit [loading, loaded, authenticated] on AuthState when execute is successfully',
      build: () {
        when(() => mockRegisterUsecaseCaller())
            .thenAnswer((_) async => const Right(tAuth));
        when(() => mockSaveTokenUsecaseCaller())
            .thenAnswer((_) async => const Right(true));
        when(() => mockCheckTokenUsecaseCaller())
            .thenAnswer((_) async => Right(tAuthToken));
        return authBloc;
      },
      act: (bloc) => bloc.add(eventCaller),
      expect: () => [
        const AuthState.loading(),
        const AuthState.loaded('Register successfully'),
        AuthState.authenticated(tAuthToken),
      ],
      verify: (_) {
        verify(() => mockRegisterUsecaseCaller());
        verify(() => mockSaveTokenUsecaseCaller());
        verify(() => mockCheckTokenUsecaseCaller());
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [loading, error] with messages on AuthState when executor is error',
      build: () {
        when(() => mockRegisterUsecaseCaller()).thenAnswer(
          (_) async => const Left(ValidatorFailure(validatorMessages)),
        );
        return authBloc;
      },
      act: (bloc) => bloc.add(eventCaller),
      expect: () => [
        const AuthState.loading(),
        const AuthState.error(messages: validatorMessages),
      ],
      verify: (_) {
        verify(() => mockRegisterUsecaseCaller());
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [loading, error] on AuthState when executor has connection error',
      build: () {
        when(() => mockRegisterUsecaseCaller()).thenAnswer((_) async =>
            const Left(ConnectionFailure('Failed connect to the Network')));
        return authBloc;
      },
      act: (bloc) => bloc.add(eventCaller),
      expect: () => [
        const AuthState.loading(),
        const AuthState.error(message: 'Failed connect to the Network'),
      ],
      verify: (_) {
        verify(() => mockRegisterUsecaseCaller());
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [Loading, error] on AuthState when executor is error',
      build: () {
        when(() => mockRegisterUsecaseCaller()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return authBloc;
      },
      act: (bloc) => bloc.add(eventCaller),
      expect: () => [
        const AuthState.loading(),
        const AuthState.error(message: 'Server Failure')
      ],
      verify: (_) {
        verify(() => mockRegisterUsecaseCaller());
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [Loading, error] on AuthState when database is error',
      build: () {
        when(() => mockRegisterUsecaseCaller())
            .thenAnswer((_) async => const Right(tAuth));
        when(() => mockSaveTokenUsecaseCaller()).thenAnswer(
            (_) async => const Left(DatabaseFailure('Database failure')));
        return authBloc;
      },
      act: (bloc) => bloc.add(eventCaller),
      expect: () => [
        const AuthState.loading(),
        const AuthState.error(message: 'Database failure'),
      ],
      verify: (_) {
        verify(() => mockRegisterUsecaseCaller());
        verify(() => mockSaveTokenUsecaseCaller());
      },
    );
  });

  group('AuthEvent.logout():', () {
    mockLogoutUsecaseCaller() => mockAuthLogout.execute(tAuthToken);
    mockRemoveTokenUsecaseCaller() => mockAuthRemoveToken.execute();
    mockTokenCheckCaller() => mockAuthGetToken.execute();

    const eventCaller = AuthEvent.logout();

    blocTest<AuthBloc, AuthState>(
      'should emit [loading, loaded, unauthenticated] on AuthState when execute is successfully',
      build: () {
        final tokenStatusResult = [tAuthToken, null];
        when(() => mockLogoutUsecaseCaller())
            .thenAnswer((_) async => const Right(true));
        when(() => mockRemoveTokenUsecaseCaller())
            .thenAnswer((_) async => const Right(true));
        when(() => mockTokenCheckCaller())
            .thenAnswer((_) async => Right(tokenStatusResult.removeAt(0)));
        return authBloc;
      },
      act: (bloc) {
        bloc.add(const AuthEvent.getStatus());
        bloc.add(eventCaller);
      },
      expect: () => [
        const AuthState.loading(),
        AuthState.authenticated(tAuthToken),
        const AuthState.loading(),
        const AuthState.loaded('Logout successfully'),
        const AuthState.unauthenticated(),
      ],
      verify: (_) {
        verify(() => mockLogoutUsecaseCaller());
        verify(() => mockTokenCheckCaller());
        verify(() => mockRemoveTokenUsecaseCaller());
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [loading, error] on AuthState when executor has connection error',
      build: () {
        when(() => mockLogoutUsecaseCaller()).thenAnswer((_) async =>
            const Left(ConnectionFailure('Failed connect to the Network')));
        when(() => mockTokenCheckCaller())
            .thenAnswer((_) async => Right(tAuthToken));
        return authBloc;
      },
      act: (bloc) {
        bloc.add(const AuthEvent.getStatus());
        bloc.add(eventCaller);
      },
      expect: () => [
        const AuthState.loading(),
        AuthState.authenticated(tAuthToken),
        const AuthState.loading(),
        const AuthState.error(message: 'Failed connect to the Network'),
      ],
      verify: (_) {
        verify(() => mockLogoutUsecaseCaller());
        verify(() => mockTokenCheckCaller());
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [Loading, error] on AuthState when executor is error',
      build: () {
        when(() => mockLogoutUsecaseCaller()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        when(() => mockTokenCheckCaller())
            .thenAnswer((_) async => Right(tAuthToken));
        return authBloc;
      },
      act: (bloc) {
        bloc.add(const AuthEvent.getStatus());
        bloc.add(eventCaller);
      },
      expect: () => [
        const AuthState.loading(),
        AuthState.authenticated(tAuthToken),
        const AuthState.loading(),
        const AuthState.error(message: 'Server Failure'),
      ],
      verify: (_) {
        verify(() => mockLogoutUsecaseCaller());
        verify(() => mockTokenCheckCaller());
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [Loading, error] on AuthState when database is error',
      build: () {
        when(() => mockLogoutUsecaseCaller())
            .thenAnswer((_) async => const Right(true));
        when(() => mockRemoveTokenUsecaseCaller()).thenAnswer(
            (_) async => const Left(DatabaseFailure('Database failure')));
        when(() => mockTokenCheckCaller())
            .thenAnswer((_) async => Right(tAuthToken));
        return authBloc;
      },
      act: (bloc) {
        bloc.add(const AuthEvent.getStatus());
        bloc.add(eventCaller);
      },
      expect: () => [
        const AuthState.loading(),
        AuthState.authenticated(tAuthToken),
        const AuthState.loading(),
        const AuthState.error(message: 'Database failure'),
      ],
      verify: (_) {
        verify(() => mockLogoutUsecaseCaller());
        verify(() => mockTokenCheckCaller());
        verify(() => mockRemoveTokenUsecaseCaller());
      },
    );
  });
}
