import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pureservers/core/config.dart';
import 'package:pureservers/data/os/os.dart';
import 'package:pureservers/data/status.dart';
import 'package:pureservers/repositories/os/os_repository.dart';

class OsRepositoryImpl implements OsRepository {
  @override
  final Dio dio;

  OsRepositoryImpl(this.dio);

  @override
  Future<List<OS>> getOs(String serverId) async {
    final res = await dio.post('${AppConfig.apiUrl}/servers/get-reinstall-oses',
        data: jsonEncode(serverId));
    return (res.data as List<dynamic>).map((e) => OS.fromJson(e)).toList();
  }

  @override
  Future<Status> reinstallOs(String serverId, String selectedOption) async {
    final res = await dio.post('${AppConfig.apiUrl}/servers/reinstall');

    switch (res.data) {
      case "Reinstalled":
        return Status(
            success: true, message: "Заявка на переустановку отправлена");
      case "NoData":
        return Status(success: false, message: "Данные не отправлены");
      case "ServerUnavailable":
        return Status(success: true, message: "Сервер не доступен");
      default:
        return Status(success: false, message: "Что-то пошло не так");
    }
  }
}
