import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pureservers/core/config.dart';
import 'package:pureservers/data/tariff/tariff.dart';
import 'package:pureservers/repositories/tariff/tariff_repository.dart';

class TariffRepositoryImpl implements TariffRepository {
  @override
  final Dio dio;

  TariffRepositoryImpl(this.dio);

  @override
  Future<List<Tariff>> getTariffs() async {
    final res = await dio.post('${AppConfig.apiUrl}/public/tariffs',
        data: jsonEncode({'currency': "EUR"}));

    return (res.data as List<dynamic>).map((e) => Tariff.fromJson(e)).toList();
  }
}
