import 'package:dartz/dartz.dart';
import 'package:flutter_store_fic7/domain/usecases/auth/auth_logout.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../../mock_helper.dart';

void main() {
  late final AuthLogout usecase;
  late final MockAuthRepository mockRepository;

  setUpAll(() {
    mockRepository = MockAuthRepository();
    usecase = AuthLogout(mockRepository);
  });
  final tAuthToken = testAuthModel.token;

  mockRepositoryCaller() => mockRepository.logout(tAuthToken);

  usecaseCaller() => usecase.execute(tAuthToken);

  test('should be return "true" when execute is successfully', () async {
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
