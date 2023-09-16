import 'package:dartz/dartz.dart';
import 'package:flutter_store_fic7/domain/usecases/category/get_category.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../../mock_helper.dart';

void main() {
  late final GetCategory usecase;
  late final MockCategoryRepository mockRepository;

  final tCategoryDetail = testCategoryDetail;

  setUpAll(() {
    mockRepository = MockCategoryRepository();
    usecase = GetCategory(mockRepository);
  });

  mockRepositoryCaller() => mockRepository.getCategory(id: 1);

  usecaseCaller() => usecase.execute(id: 1);

  test('should be a return Category entity execute is successfully', () async {
    // Arrange
    when(() => mockRepositoryCaller())
        .thenAnswer((_) async => Right(tCategoryDetail));
    // Act
    final call = await usecaseCaller();
    // Assert
    verify(() => mockRepositoryCaller());
    expect(call, Right(tCategoryDetail));
  });
}
