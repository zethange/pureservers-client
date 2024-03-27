import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pureservers/core/config.dart';
import 'package:pureservers/data/server/server.dart';
import 'package:pureservers/data/status.dart';
import 'package:pureservers/repositories/server/server_repository.dart';

class ServerRepositoryImpl implements ServerRepository {
  @override
  final Dio dio;

  ServerRepositoryImpl(this.dio);

  @override
  Future<List<Server>> getServers() async {
    debugPrint('start get servers');
    final res = await dio.get('${AppConfig.apiUrl}/servers/list');
    debugPrint('end get servers');
    final List<Server> list =
        (res.data as List<dynamic>).map((e) => Server.fromJson(e)).toList();
    return list;
  }

  @override
  Future<String> startServer(String serverId) async {
    final res = await dio.post('${AppConfig.apiUrl}/servers/start',
        data: jsonEncode(serverId));
    return res.data;
  }

  @override
  Future<String> stopServer(String serverId) async {
    final res = await dio.post('${AppConfig.apiUrl}/servers/stop',
        data: jsonEncode(serverId));
    return res.data;
  }

  @override
  Future<String> restartServer(String serverId) async {
    final res = await dio.post('${AppConfig.apiUrl}/servers/restart',
        data: jsonEncode(serverId));
    return res.data;
  }

  @override
  Future<Status> buyServer(String tariffId) async {
    final res = await dio.post(
      '${AppConfig.apiUrl}/servers/order',
      data: jsonEncode(tariffId),
      options: Options(
        validateStatus: (status) => true,
      ),
    );

    switch (res.data) {
      case "NoData":
        return Status(success: false, message: "No selected id");
      case "NoIpsAvailable":
        return Status(
          success: false,
          message: "Нет доступных IP адрессов",
        );
      case "NoOsAvailable":
        return Status(
          success: false,
          message: "Нет доступных ОС на узле",
        );
      case "FailedToCreateServer":
        return Status(
          success: false,
          message: "При создании сервера произошла ошибка",
        );
      case "WhoAreU":
        return Status(
          success: false,
          message: "Вы не вошли в аккаунт",
        );
      case "NotEnoughFunds":
        return Status(
          success: false,
          message: "Недостаточно денег на балансе",
        );
      case "NoTariff":
        return Status(
          success: false,
          message: "Тариф не существует",
        );
      case "NoNodes":
        return Status(success: false, message: "Нет доступных нод");
      default:
        return Status(success: true, message: 'Сервер создан');
    }
  }

  @override
  Future<Status> enableNesting(String serverId) async {
    final res = await dio.post(
      '${AppConfig.apiUrl}/servers/enable-feature',
      data: jsonEncode({
        "feature": "nesting",
        "server_id": serverId,
      }),
      options: Options(
        validateStatus: (status) => true,
      ),
    );

    if (res.statusCode == 200 && res.data == "Requested") {
      return Status(
        success: true,
        message: "Заявка на включение nesting отправлена",
      );
    }

    return Status(success: false, message: "Произошла ошибка");
  }

  @override
  Future<Status> enableTun(String serverId) async {
    final res = await dio.post('${AppConfig.apiUrl}/servers/enable-feature',
        data: jsonEncode({
          "feature": "tuntap",
          "server_id": serverId,
        }),
        options: Options(
          validateStatus: (status) => true,
        ));

    if (res.statusCode == 200 && res.data == "Requested") {
      return Status(
          success: true, message: "Заявка на включение tun/tap отправлена");
    }

    return Status(success: false, message: "Произошла ошибка");
  }
}
