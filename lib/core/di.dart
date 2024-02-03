import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pureservers/repositories/auth_repository.dart';
import 'package:pureservers/repositories/os_repository.dart';
import 'package:pureservers/repositories/server_repository.dart';
import 'package:pureservers/repositories/tariff_repository.dart';

final getIt = GetIt.I;

Future<void> configureDependence() async {
  final Dio dio = Dio();
  getIt.registerSingleton(dio);
  getIt.registerFactory(() => AuthRepository(getIt()));
  getIt.registerFactory(() => ServerRepository(getIt()));
  getIt.registerFactory(() => TariffRepository(getIt()));
  getIt.registerFactory(() => OsRepository(getIt()));
}
