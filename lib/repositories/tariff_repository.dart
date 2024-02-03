import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pureservers/core/config.dart';
import 'package:pureservers/data/tariff/tariff.dart';

class TariffRepository {
  final Dio dio;

  TariffRepository(this.dio);

  Future<List<Tariff>> getTariffs() async {
    final res = await dio.post('${AppConfig.apiUrl}/public/tariffs',
        data: jsonEncode({'currency': "EUR"}));

    return (res.data as List<dynamic>).map((e) => Tariff.fromJson(e)).toList();
  }
}
