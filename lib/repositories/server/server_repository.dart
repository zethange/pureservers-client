import 'package:dio/dio.dart';
import 'package:pureservers/data/server/server.dart';
import 'package:pureservers/data/status.dart';

abstract class ServerRepository {
  final Dio dio;
  ServerRepository(this.dio);

  Future<List<Server>> getServers();
  Future<String> startServer(String serverId);
  Future<String> stopServer(String serverId);
  Future<String> restartServer(String serverId);
  Future<Status> buyServer(String tariffId);

  Future<Status> enableNesting(String serverId);
  Future<Status> enableTun(String serverId);
}
