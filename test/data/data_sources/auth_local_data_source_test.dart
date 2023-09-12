import 'package:flutter_store_fic7/data/data_sources/auth_local_data_source.dart';
import 'package:flutter_store_fic7/utils/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_object.dart';
import '../../mock_helper.dart';

void main() {
  late final AuthLocalDataSource dataSource;
  late final MockSharedPreferences mockSharedPreferences;

  setUpAll(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        AuthLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  const prefKey = 'auth_token';
  const tAuthModel = testAuthModel;
  final tAuthToken = tAuthModel.token;

  group('getAuthToken function:', () {
    test('should return authToken when process is successfully', () async {
      // Arrange
      when(() => mockSharedPreferences.getString(prefKey))
          .thenAnswer((_) => tAuthToken);
      // Act
      final call = await dataSource.getAuthToken();
      // Assert
      expect(call, tAuthToken);
    });

    test('should return null when saved token is null', () async {
      // Arrange
      when(() => mockSharedPreferences.getString(prefKey))
          .thenAnswer((_) => null);
      // Act
      final call = await dataSource.getAuthToken();
      // Assert
      expect(call, null);
    });

    test('should return DatabaseException when getting saved token is error',
        () {
      // Arrange
      when(() => mockSharedPreferences.getString(prefKey))
          .thenThrow(Exception());
      // Act
      final call = dataSource.getAuthToken();
      // Assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('removeToken function:', () {
    test('should return true when remove token is successfully', () async {
      // Arrange
      when(() => mockSharedPreferences.remove(prefKey))
          .thenAnswer((_) async => true);
      // Act
      final call = await dataSource.removeAuthToken();
      // Assert
      expect(call, true);
    });

    test('should return DatabaseException when remove token is unsuccessfully',
        () async {
      // Arrange
      when(() => mockSharedPreferences.remove(prefKey))
          .thenAnswer((_) async => false);
      // Act
      final call = dataSource.removeAuthToken();
      // Assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });

    test('should return DatabaseException when saved token is error', () {
      // Arrange
      when(() => mockSharedPreferences.remove(prefKey)).thenThrow(Exception());
      // Act
      final call = dataSource.removeAuthToken();
      // Assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('saveToken function:', () {
    test('should return true when save token is successfully', () async {
      // Arrange
      when(() => mockSharedPreferences.setString(prefKey, tAuthToken))
          .thenAnswer((_) async => true);
      // Act
      final call = await dataSource.saveAuthToken(tAuthModel.token);
      // Assert
      expect(call, true);
    });

    test('should return DatabaseException when save token is unsuccessfully',
        () async {
      // Arrange
      when(() => mockSharedPreferences.setString(prefKey, tAuthToken))
          .thenAnswer((_) async => false);
      // Act
      final call = dataSource.saveAuthToken(tAuthModel.token);
      // Assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });

    test('should return DatabaseException when saved token is error', () {
      // Arrange
      when(() => mockSharedPreferences.setString(prefKey, tAuthToken))
          .thenThrow(Exception());
      // Act
      final call = dataSource.saveAuthToken(tAuthModel.token);
      // Assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });
}
