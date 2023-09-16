import 'package:flutter_store_fic7/data/api/base_api.dart';
import 'package:flutter_store_fic7/data/data_sources/category_remote_data_source.dart';
import 'package:flutter_store_fic7/utils/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_object.dart';
import '../../json_reader.dart';
import '../../mock_helper.dart';

void main() {
  late final CategoryRemoteDataSource dataSource;
  late final MockClient mockClient;

  setUpAll(() {
    mockClient = MockClient();
    dataSource = CategoryRemoteDataSourceImpl(client: mockClient);
  });

  final baseApi = BaseApi();

  group('getCategories():', () {
    const tCategoryCollection = testCategoryCollectionModel;
    final tCategoriesApiResponse = jsonReader(
      'dummy_data/categories_api_response.json',
    );

    mockApiCaller() => mockClient.get(Uri.parse(baseApi.categoryPath),
        headers: baseApi.headers);

    test('should return List CategoryCollection when response code is 200',
        () async {
      // Arrange
      when(() => mockApiCaller())
          .thenAnswer((_) async => http.Response(tCategoriesApiResponse, 200));

      // Act
      final call = await dataSource.getCategories();

      // Assert
      expect(call, tCategoryCollection);
    });

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(() => mockApiCaller()).thenAnswer(
            (_) async => http.Response('{"message": "Not Found"}', 404));
        // act
        final call = dataSource.getCategories();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('getCategory():', () {
    final tCategory = testCategoryModelDetail;
    final tCategoryApiResponse = jsonReader(
      'dummy_data/category_api_response.json',
    );

    mockApiCaller() => mockClient.get(Uri.parse('${baseApi.categoryPath}/1'),
        headers: baseApi.headers);

    test('should return CategoryModel when response code is 200', () async {
      // Arrange
      when(() => mockApiCaller())
          .thenAnswer((_) async => http.Response(tCategoryApiResponse, 200));

      // Act
      final call = await dataSource.getCategory(id: 1);

      // Assert
      expect(call, tCategory);
    });

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(() => mockApiCaller()).thenAnswer(
            (_) async => http.Response('{"message": "Not Found"}', 404));
        // act
        final call = dataSource.getCategory(id: 1);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });
}
