import 'package:flutter_store_fic7/data/api/base_api.dart';
import 'package:flutter_store_fic7/data/data_sources/product_remote_data_source.dart';
import 'package:flutter_store_fic7/utils/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_object.dart';
import '../../json_reader.dart';
import '../../mock_helper.dart';

void main() {
  late final ProductRemoteDataSource dataSource;
  late final MockClient mockClient;

  setUpAll(() {
    mockClient = MockClient();
    dataSource = ProductRemoteDataSourceImpl(client: mockClient);
  });

  final baseApi = BaseApi();

  group('getProducts():', () {
    const tProductCollection = testProductCollectionModel;
    final tProductsApiResponse = jsonReader(
      'dummy_data/products_api_response.json',
    );

    mockApiCaller() => mockClient.get(Uri.parse(baseApi.productPath),
        headers: baseApi.headers);

    test('should return List ProductCollection when response code is 200',
        () async {
      // Arrange
      when(() => mockApiCaller())
          .thenAnswer((_) async => http.Response(tProductsApiResponse, 200));

      // Act
      final call = await dataSource.getProducts();

      // Assert
      expect(call, tProductCollection);
    });

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(() => mockApiCaller()).thenAnswer(
            (_) async => http.Response('{"message": "Not Found"}', 404));
        // act
        final call = dataSource.getProducts();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('getProductsByCategory():', () {
    const tProductCollection = testProductCollectionModel;
    final tProductsApiResponse = jsonReader(
      'dummy_data/products_api_response.json',
    );

    mockApiCaller() => mockClient.get(
          Uri.parse('${baseApi.productPath}?category-id=1'),
          headers: baseApi.headers,
        );

    test('should return List ProductCollection when response code is 200',
        () async {
      // Arrange
      when(() => mockApiCaller())
          .thenAnswer((_) async => http.Response(tProductsApiResponse, 200));

      // Act
      final call = await dataSource.getProductsByCategory(1);

      // Assert
      expect(call, tProductCollection);
    });

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(() => mockApiCaller()).thenAnswer(
            (_) async => http.Response('{"message": "Not Found"}', 404));
        // act
        final call = dataSource.getProductsByCategory(1);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('getProduct():', () {
    final tProduct = testProductModelDetail;
    final tProductApiResponse = jsonReader(
      'dummy_data/product_api_response.json',
    );

    mockApiCaller() => mockClient.get(Uri.parse('${baseApi.productPath}/1'),
        headers: baseApi.headers);

    test('should return ProductModel when response code is 200', () async {
      // Arrange
      when(() => mockApiCaller())
          .thenAnswer((_) async => http.Response(tProductApiResponse, 200));

      // Act
      final call = await dataSource.getProduct(id: 1);

      // Assert
      expect(call, tProduct);
    });

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(() => mockApiCaller()).thenAnswer(
            (_) async => http.Response('{"message": "Not Found"}', 404));
        // act
        final call = dataSource.getProduct(id: 1);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });
}
