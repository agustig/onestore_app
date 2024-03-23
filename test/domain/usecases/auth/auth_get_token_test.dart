import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onestore_app/domain/usecases/auth/auth_get_token.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../../mock_helper.dart';

void main() {
  late final AuthGetToken usecase;
  late final MockAuthRepository mockRepository;

  setUpAll(() {
    mockRepository = MockAuthRepository();
    usecase = AuthGetToken(mockRepository);
  });

  final tAuthToken = testAuthModel.token;

  mockRepositoryCaller() => mockRepository.getAuthToken();

  usecaseCaller() => usecase.execute();

  test('should be a return a token when execute is successfully', () async {
    // Arrange
    when(() => mockRepositoryCaller())
        .thenAnswer((_) async => Right(tAuthToken));
    // Act
    final call = await usecaseCaller();
    // Assert
    verify(() => mockRepositoryCaller());
    expect(call, Right(tAuthToken));
  });
}
