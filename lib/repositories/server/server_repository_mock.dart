import 'dart:math';

import 'package:dio/dio.dart';
import 'package:pureservers/data/server/server.dart';
import 'package:pureservers/data/status.dart';
import 'package:pureservers/repositories/server/server_repository.dart';

class ServerRepositoryMock implements ServerRepository {
  @override
  final Dio dio;

  ServerRepositoryMock(this.dio);

  @override
  Future<List<Server>> getServers() async {
    return List<Server>.of([
      Server(
        id: "123",
        expiresAt: DateTime.now(),
        os: "Rach Linux",
        linkedIps: [
          LinkedIp(id: "123", ip: "1.1.1.1"),
        ],
        numId: 1,
        password: "12345678",
        username: "root",
        tariffId: "Business+",
        tariffName: "Business+",
        status: "active",
        state: State(
          cpu: Random().nextDouble(),
          maxCpu: 1,
          ram: Random().nextDouble(),
          maxRam: 32,
          disk: Random().nextDouble(),
          maxDisk: 1024,
          status: "running",
        ),
      ),
      Server(
        id: "124",
        expiresAt: DateTime.now(),
        os: "Pomidor Linux",
        linkedIps: [
          LinkedIp(id: "123", ip: "8.8.8.8"),
        ],
        numId: 1,
        password: "12345678",
        username: "root",
        tariffId: "Business+",
        tariffName: "Business+",
        status: "active",
        state: State(
          cpu: Random().nextDouble(),
          maxCpu: 1,
          ram: Random().nextDouble(),
          maxRam: 32,
          disk: Random().nextDouble(),
          maxDisk: 1024,
          status: "running",
        ),
      ),
    ]);
  }

  @override
  Future<String> startServer(String serverId) async {
    return "Requested";
  }

  @override
  Future<String> stopServer(String serverId) async {
    return "Requested";
  }

  @override
  Future<String> restartServer(String serverId) async {
    return "Requested";
  }

  @override
  Future<Status> buyServer(String tariffId) async {
    return Status(success: true, message: "Server created");
  }

  @override
  Future<Status> enableNesting(String serverId) async {
    return Status(success: true, message: "Ok");
  }

  @override
  Future<Status> enableTun(String serverId) async {
    return Status(success: true, message: "Ok");
  }
}
