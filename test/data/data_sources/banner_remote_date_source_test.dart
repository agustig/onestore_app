import 'package:onestore_app/data/data_sources/banner_remote_data_source.dart';
import 'package:onestore_app/utils/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_object.dart';
import '../../json_reader.dart';
import '../../mock_helper.dart';

void main() {
  late final BannerRemoteDataSource dataSource;
  late final MockClient mockClient;

  setUpAll(() {
    mockClient = MockClient();
    dataSource = BannerRemoteDataSourceImpl(client: mockClient);
  });

  final mockRemoteApi = MockRemoteApi();

  group('getBanners():', () {
    const tBannersModels = [testBannerModel];
    final tBannerApiResponse =
        jsonReader('dummy_data/banner_api_response.json');

    mockApiCaller() => mockClient.get(
          Uri.parse(mockRemoteApi.bannerPath),
          headers: mockRemoteApi.headers,
        );

    test(
        'should return a List of BannerModel when fetch banners data from remote is success',
        () async {
      // Arrange
      when(() => mockApiCaller())
          .thenAnswer((_) async => http.Response(tBannerApiResponse, 200));

      // Act
      final call = await dataSource.getBanners();

      // Assert
      expect(call, tBannersModels);
    });

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(() => mockApiCaller()).thenAnswer(
            (_) async => http.Response('{"message": "Not Found"}', 404));
        // act
        final call = dataSource.getBanners();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });
}
