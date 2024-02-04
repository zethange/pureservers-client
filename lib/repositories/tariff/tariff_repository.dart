import 'package:dio/dio.dart';
import 'package:pureservers/data/tariff/tariff.dart';

abstract class TariffRepository {
  final Dio dio;
  TariffRepository(this.dio);

  Future<List<Tariff>> getTariffs();
}
