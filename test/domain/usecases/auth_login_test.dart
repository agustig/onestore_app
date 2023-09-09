import 'package:dartz/dartz.dart';
import 'package:flutter_store_fic7/domain/usecases/auth_login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_object.dart';
import '../../mock_helper.dart';

void main() {
  late final AuthLogin usecase;
  late final MockAuthRepository mockRepository;

  setUpAll(() {
    mockRepository = MockAuthRepository();
    usecase = AuthLogin(mockRepository);
  });

  const tAuth = testAuth;

  mockRepositoryCaller() => mockRepository.login(
        email: 'marlee.ledner@example.net',
        password: 'password',
      );

  usecaseCaller() => usecase.execute(
        email: 'marlee.ledner@example.net',
        password: 'password',
      );

  test('should be a valid Auth when execute is successfully', () async {
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
