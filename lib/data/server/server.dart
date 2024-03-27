import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'server.g.dart';

@JsonSerializable()
class LinkedIp {
  @JsonKey(name: '_id')
  String id;
  String ip;

  LinkedIp({
    required this.id,
    required this.ip,
  });

  factory LinkedIp.fromJson(dynamic json) {
    return _$LinkedIpFromJson(json);
  }
}

@JsonSerializable()
class State {
  double cpu;
  @JsonKey(name: 'max_cpu')
  int maxCpu;

  double ram;
  @JsonKey(name: 'max_ram')
  int maxRam;

  double disk;
  @JsonKey(name: 'max_disk')
  int maxDisk;

  String status;

  State({
    required this.cpu,
    required this.maxCpu,
    required this.ram,
    required this.maxRam,
    required this.disk,
    required this.maxDisk,
    required this.status,
  });

  factory State.fromJson(dynamic json) {
    return _$StateFromJson(json);
  }
}

@JsonSerializable()
class Server {
  @JsonKey(name: '_id')
  String id;
  String os;
  String username;
  String password;
  @JsonKey(name: 'tariff_id')
  String tariffId;
  @JsonKey(name: 'expires_at', fromJson: _fromJson)
  DateTime expiresAt;
  String status;
  @JsonKey(name: 'num_id')
  int numId;

  @JsonKey(name: 'linked_ips')
  List<LinkedIp> linkedIps;

  @JsonKey(name: 'tariff_name')
  String tariffName;

  @JsonKey(name: 'tuntap_enabled')
  bool? tunTapEnabled;

  @JsonKey(name: 'nesting_enabled')
  bool? nestingEnabled;

  State state;

  Server({
    required this.id,
    required this.os,
    required this.username,
    required this.password,
    required this.tariffId,
    required this.expiresAt,
    required this.status,
    required this.numId,
    required this.linkedIps,
    required this.tariffName,
    required this.state,
  });

  factory Server.fromJson(dynamic json) {
    return _$ServerFromJson(json);
  }

  static DateTime _fromJson(int int) =>
      DateTime.fromMillisecondsSinceEpoch(int);

  String getStatus() {
    if (status == "active") {
      switch (state.status) {
        case 'running':
          return 'Запущен';
        default:
          return 'Остановлен';
      }
    } else if (status == "expired") {
      return 'Не оплачен';
    }

    return 'Error';
  }

  Color getStatusColor() {
    if (status == "active") {
      switch (state.status) {
        case 'running':
          return Colors.green;
        default:
          return Colors.red;
      }
    } else if (status == "expired") {
      return Colors.orange;
    }

    return Colors.black;
  }

  String getTunTap() {
    final enabled = tunTapEnabled ?? false;
    if (!enabled) {
      return "Выключен";
    }
    return "Включен";
  }

  String getNesting() {
    final enabled = nestingEnabled ?? false;
    if (!enabled) {
      return "Выключен";
    }
    return "Включен";
  }
}
