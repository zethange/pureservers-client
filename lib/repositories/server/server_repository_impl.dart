import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pureservers/core/config.dart';
import 'package:pureservers/data/server/server.dart';
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
}
