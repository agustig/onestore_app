import 'dart:convert';

import 'package:flutter_store_fic7/data/data_sources/auth_remote_data_source.dart';
import 'package:flutter_store_fic7/data/models/auth_model.dart';
import 'package:flutter_store_fic7/utils/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_object.dart';
import '../../json_reader.dart';
import '../../mock_helper.dart';

void main() {
  late final AuthRemoteDataSource dataSource;
  late final MockClient mockClient;

  setUpAll(() {
    mockClient = MockClient();
    dataSource = AuthRemoteDataSourceImpl(client: mockClient);
  });

  final mockRemoteApi = MockRemoteApi();

  group('Login function:', () {
    final tAuthModel = AuthModel.fromMap(
      json.decode(jsonReader('dummy_data/auth.json')),
    );
    final tAuthApiResponseJson = jsonReader(
      'dummy_data/auth_api_response.json',
    );
    final tAuthApiResponse400Json = jsonReader(
      'dummy_data/auth_api_response_400.json',
    );
    final tAuthLoginData = json.encode(testAuthLoginData);

    dataSourceCaller() => dataSource.login(
          email: 'marlee.ledner@example.net',
          password: 'password',
        );

    mockApiCaller() => mockClient.post(
          Uri.parse(mockRemoteApi.loginPath),
          headers: mockRemoteApi.headers,
          body: tAuthLoginData,
        );

    test('should return AuthModel when the response code is 200', () async {
      // Arrange
      when(() => mockApiCaller())
          .thenAnswer((_) async => http.Response(tAuthApiResponseJson, 200));
      // Act
      final call = await dataSourceCaller();
      // Assert
      expect(call, tAuthModel);
    });

    test(
      'should throw a ValidatorException when the response code is 400',
      () async {
        // arrange
        when(() => mockApiCaller()).thenAnswer(
          (_) async => http.Response(tAuthApiResponse400Json, 400),
        );
        // act
        final call = dataSourceCaller();
        // assert
        expect(() => call, throwsA(isA<ValidatorException>()));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(() => mockApiCaller()).thenAnswer(
            (_) async => http.Response('{"message": "Not Found"}', 404));
        // act
        final call = dataSourceCaller();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('Register function:', () {
    final tAuthModel = AuthModel.fromMap(
      json.decode(jsonReader('dummy_data/auth.json')),
    );
    final tAuthApiResponseJson = jsonReader(
      'dummy_data/auth_api_response.json',
    );
    final tAuthApiResponse400Json = jsonReader(
      'dummy_data/auth_api_response_400.json',
    );
    final tAuthRegisterData = json.encode(testAuthRegisterData);

    dataSourceCaller() => dataSource.register(
          name: 'Mr. Manuela Zboncak III',
          email: 'marlee.ledner@example.net',
          password: 'password',
          passwordConfirmation: 'password',
        );

    mockApiCaller() => mockClient.post(
          Uri.parse(mockRemoteApi.registerPath),
          headers: mockRemoteApi.headers,
          body: tAuthRegisterData,
        );

    test('should return AuthModel when the response code is 200', () async {
      // Arrange
      when(() => mockApiCaller())
          .thenAnswer((_) async => http.Response(tAuthApiResponseJson, 200));
      // Act
      final call = await dataSourceCaller();
      // Assert
      expect(call, tAuthModel);
    });

    test(
      'should throw a ValidatorException when the response code is 400',
      () async {
        // arrange
        when(() => mockApiCaller()).thenAnswer(
          (_) async => http.Response(tAuthApiResponse400Json, 400),
        );
        // act
        final call = dataSourceCaller();
        // assert
        expect(() => call, throwsA(isA<ValidatorException>()));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(() => mockApiCaller()).thenAnswer(
            (_) async => http.Response('{"message": "Not Found"}', 404));
        // act
        final call = dataSourceCaller();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('Logout function:', () {
    final tAuthToken = testAuthModel.token;

    dataSourceCaller() => dataSource.logout(tAuthToken);

    mockApiCaller() => mockClient.post(
          Uri.parse(mockRemoteApi.logoutPath),
          headers: mockRemoteApi.authyHeaders(tAuthToken),
        );

    test('should return true when the response code is 200', () async {
      // Arrange
      when(() => mockApiCaller())
          .thenAnswer((_) async => http.Response('Logout success', 200));
      // Act
      final call = await dataSourceCaller();
      // Assert
      expect(call, true);
    });

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(() => mockApiCaller()).thenAnswer(
            (_) async => http.Response('{"message": "Not Found"}', 404));
        // act
        final call = dataSourceCaller();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });
}
