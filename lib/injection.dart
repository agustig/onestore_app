import 'package:flutter_store_fic7/data/data_sources/auth_remote_data_source.dart';
import 'package:flutter_store_fic7/data/repositories/auth_repository_impl.dart';
import 'package:flutter_store_fic7/domain/repositories/auth_repository.dart';
import 'package:flutter_store_fic7/domain/usecases/auth_login.dart';
import 'package:flutter_store_fic7/domain/usecases/auth_register.dart';
import 'package:flutter_store_fic7/presentation/bloc/login_bloc.dart';
import 'package:flutter_store_fic7/presentation/bloc/register_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  // Bloc
  locator.registerFactory(() => RegisterBloc(locator()));
  locator.registerFactory(() => LoginBloc(locator()));

  // Usecases
  locator.registerLazySingleton(() => AuthRegister(locator()));
  locator.registerLazySingleton(() => AuthLogin(locator()));

  // Repositories
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: locator()),
  );

  // DataSources
  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: locator()),
  );

  // External
  locator.registerLazySingleton(() => http.Client());
}
