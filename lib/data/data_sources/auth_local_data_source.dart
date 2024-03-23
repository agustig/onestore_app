import 'package:onestore_app/utils/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<String?> getAuthToken();
  Future<bool> removeAuthToken();
  Future<bool> saveAuthToken(String authToken);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const _prefKey = 'auth_token';

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<String?> getAuthToken() async {
    try {
      return sharedPreferences.getString(_prefKey);
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<bool> removeAuthToken() async {
    try {
      final result = await sharedPreferences.remove(_prefKey);
      if (result) {
        return true;
      }
      throw DatabaseException('Failed to remove token');
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<bool> saveAuthToken(String authToken) async {
    try {
      final result = await sharedPreferences.setString(_prefKey, authToken);
      if (result) {
        return true;
      }
      throw DatabaseException('Failed to save token');
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
