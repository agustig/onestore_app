import 'package:dartz/dartz.dart';
import 'package:flutter_store_fic7/domain/usecases/category/get_categories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../../mock_helper.dart';

void main() {
  late final GetCategories usecase;
  late final MockCategoryRepository mockRepository;

  const tCategoryCollection = testCategoryCollection;

  setUpAll(() {
    mockRepository = MockCategoryRepository();
    usecase = GetCategories(mockRepository);
  });

  mockRepositoryCaller() => mockRepository.getCategories();

  usecaseCaller() => usecase.execute();

  test(
      'should be a return Collection entity for category when execute is successfully',
      () async {
    // Arrange
    when(() => mockRepositoryCaller())
        .thenAnswer((_) async => const Right(tCategoryCollection));
    // Act
    final call = await usecaseCaller();
    // Assert
    verify(() => mockRepositoryCaller());
    expect(call, const Right(tCategoryCollection));
  });
}
