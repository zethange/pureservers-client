import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:pureservers/repositories/auth/auth_repository.dart';
import 'package:pureservers/repositories/auth/auth_repository_impl.dart';
import 'package:pureservers/repositories/auth/auth_repository_mock.dart';
import 'package:pureservers/repositories/os/os_repository.dart';
import 'package:pureservers/repositories/os/os_repository_impl.dart';
import 'package:pureservers/repositories/os/os_repository_mock.dart';
import 'package:pureservers/repositories/server/server_repository.dart';
import 'package:pureservers/repositories/server/server_repository_impl.dart';
import 'package:pureservers/repositories/server/server_repository_mock.dart';
import 'package:pureservers/repositories/tariff/tariff_repository.dart';
import 'package:pureservers/repositories/tariff/tariff_repository_impl.dart';
import 'package:pureservers/repositories/user/user_repository.dart';
import 'package:pureservers/repositories/user/user_repository_impl.dart';
import 'package:pureservers/repositories/user/user_repository_mock.dart';

final getIt = GetIt.I;

Future<void> configureDependence() async {
  final Dio dio = Dio();
  getIt.registerSingleton(dio);

  if (kReleaseMode) {
    getIt.registerFactory<AuthRepository>(() => AuthRepositoryImpl(getIt()));
    getIt
        .registerFactory<ServerRepository>(() => ServerRepositoryImpl(getIt()));
    getIt
        .registerFactory<TariffRepository>(() => TariffRepositoryImpl(getIt()));
    getIt.registerFactory<OsRepository>(() => OsRepositoryImpl(getIt()));
    getIt.registerFactory<UserRepository>(() => UserRepositoryImpl(getIt()));
  } else {
    getIt.registerFactory<AuthRepository>(() => AuthRepositoryMock(getIt()));
    getIt
        .registerFactory<ServerRepository>(() => ServerRepositoryMock(getIt()));
    getIt
        .registerFactory<TariffRepository>(() => TariffRepositoryImpl(getIt()));
    getIt.registerFactory<OsRepository>(() => OsRepositoryMock(getIt()));
    getIt.registerFactory<UserRepository>(() => UserRepositoryMock(getIt()));
  }
}
