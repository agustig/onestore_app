import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onestore_app/domain/usecases/auth/auth_save_token.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../../mock_helper.dart';

void main() {
  late final AuthSaveToken usecase;
  late final MockAuthRepository mockRepository;

  setUpAll(() {
    mockRepository = MockAuthRepository();
    usecase = AuthSaveToken(mockRepository);
  });
  final tAuthToken = testAuth.token;

  mockRepositoryCaller() => mockRepository.saveAuthToken(tAuthToken);

  usecaseCaller() => usecase.execute(tAuthToken);

  test('should be a return true when execute is successfully', () async {
    // Arrange
    when(() => mockRepositoryCaller())
        .thenAnswer((_) async => const Right(true));
    // Act
    final call = await usecaseCaller();
    // Assert
    verify(() => mockRepositoryCaller());
    expect(call, const Right(true));
  });
}
