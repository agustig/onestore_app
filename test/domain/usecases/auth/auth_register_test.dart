import 'package:dartz/dartz.dart';
import 'package:flutter_store_fic7/domain/usecases/auth/auth_register.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../../mock_helper.dart';

void main() {
  late final AuthRegister usecase;
  late final MockAuthRepository mockRepository;
  const tAuth = testAuth;

  setUpAll(() {
    mockRepository = MockAuthRepository();
    usecase = AuthRegister(mockRepository);
  });

  mockRepositoryCaller() => mockRepository.register(
        name: 'Mr. Manuela Zboncak III',
        email: 'marlee.ledner@example.net',
        password: 'password',
        passwordConfirmation: 'password',
      );

  usecaseCaller() => usecase.execute(
        name: 'Mr. Manuela Zboncak III',
        email: 'marlee.ledner@example.net',
        password: 'password',
        passwordConfirmation: 'password',
      );

  test('should be a return Auth entity when execute is successfully', () async {
    // Arrange
    when(() => mockRepositoryCaller())
        .thenAnswer((_) async => const Right(tAuth));
    // Act
    final call = await usecaseCaller();
    // Assert
    verify(() => mockRepositoryCaller());
    expect(call, const Right(tAuth));
  });
}
