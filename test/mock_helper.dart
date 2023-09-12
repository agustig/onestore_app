import 'package:flutter_store_fic7/data/data_sources/auth_local_data_source.dart';
import 'package:flutter_store_fic7/data/data_sources/auth_remote_data_source.dart';
import 'package:flutter_store_fic7/domain/repositories/auth_repository.dart';
import 'package:flutter_store_fic7/domain/usecases/auth_get_token.dart';
import 'package:flutter_store_fic7/domain/usecases/auth_login.dart';
import 'package:flutter_store_fic7/domain/usecases/auth_logout.dart';
import 'package:flutter_store_fic7/domain/usecases/auth_register.dart';
import 'package:flutter_store_fic7/domain/usecases/auth_remove_token.dart';
import 'package:flutter_store_fic7/domain/usecases/auth_save_token.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockClient extends Mock implements http.Client {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockAuthRegister extends Mock implements AuthRegister {}

class MockAuthLogin extends Mock implements AuthLogin {}

class MockAuthLogout extends Mock implements AuthLogout {}

class MockAuthGetToken extends Mock implements AuthGetToken {}

class MockAuthRemoveToken extends Mock implements AuthRemoveToken {}

class MockAuthSaveToken extends Mock implements AuthSaveToken {}
