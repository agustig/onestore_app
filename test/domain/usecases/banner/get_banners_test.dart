import 'package:dartz/dartz.dart';
import 'package:flutter_store_fic7/domain/usecases/banner/get_banners.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../../mock_helper.dart';

void main() {
  late final GetBanners usecase;
  late final MockBannerRepository mockRepository;

  const tBanners = [testBanner];

  setUpAll(() {
    mockRepository = MockBannerRepository();
    usecase = GetBanners(mockRepository);
  });

  mockRepositoryCaller() => mockRepository.getBanners();

  usecaseCaller() => usecase.execute();

  test('should be a return List of Banner entity when execute is successfully',
      () async {
    // Arrange
    when(() => mockRepositoryCaller())
        .thenAnswer((_) async => const Right(tBanners));
    // Act
    final call = await usecaseCaller();
    // Assert
    verify(() => mockRepositoryCaller());
    expect(call, const Right(tBanners));
  });
}
