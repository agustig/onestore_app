import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:onestore_app/data/data_sources/profile_remote_data_source.dart';
import 'package:onestore_app/utils/exceptions.dart';

import '../../dummy_data/dummy_object.dart';
import '../../json_reader.dart';
import '../../mock_helper.dart';

void main() {
  late final ProfileRemoteDataSource dataSource;
  late final MockClient mockClient;

  setUpAll(() {
    mockClient = MockClient();
    dataSource = ProfileRemoteDataSourceImpl(client: mockClient);
  });

  final mockRemoteApi = MockRemoteApi();
  final tAuthToken = testAuthModel.token;

  group('getProfile():', () {
    const tUserModel = testUserModel;
    final tProfileApiResponse = jsonReader(
      'dummy_data/profile_api_response.json',
    );

    mockApiCaller() => mockClient.get(
          Uri.parse(mockRemoteApi.profilePath),
          headers: mockRemoteApi.authyHeaders(tAuthToken),
        );

    test('should return UserModel when response code is 200', () async {
      // Arrange
      when(() => mockApiCaller())
          .thenAnswer((_) async => http.Response(tProfileApiResponse, 200));

      // Act
      final call = await dataSource.getProfile(authToken: tAuthToken);

      // Assert
      expect(call, tUserModel);
    });

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(() => mockApiCaller()).thenAnswer(
            (_) async => http.Response('{"message": "Not Found"}', 404));
        // act
        final call = dataSource.getProfile(authToken: tAuthToken);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });
}
