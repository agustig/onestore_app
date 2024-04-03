import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onestore_app/domain/usecases/profile/get_profile.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../../mock_helper.dart';

void main() {
  late final GetProfile usecase;
  late final MockProfileRepository mockRepository;

  const tUser = testUser;
  final tAuthToken = testAuthModel.token;

  setUpAll(() {
    mockRepository = MockProfileRepository();
    usecase = GetProfile(mockRepository);
  });

  mockRepositoryCaller() => mockRepository.getProfile(authToken: tAuthToken);

  usecaseCaller() => usecase.execute(authToken: tAuthToken);

  test('should be a return Product entity execute is successfully', () async {
    // Arrange
    when(() => mockRepositoryCaller())
        .thenAnswer((_) async => const Right(tUser));
    // Act
    final call = await usecaseCaller();
    // Assert
    verify(() => mockRepositoryCaller());
    expect(call, const Right(tUser));
  });
}
