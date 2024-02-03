// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinkedIp _$LinkedIpFromJson(Map<String, dynamic> json) => LinkedIp(
      id: json['_id'] as String,
      ip: json['ip'] as String,
    );

Map<String, dynamic> _$LinkedIpToJson(LinkedIp instance) => <String, dynamic>{
      '_id': instance.id,
      'ip': instance.ip,
    };

State _$StateFromJson(Map<String, dynamic> json) => State(
      cpu: (json['cpu'] as num).toDouble(),
      maxCpu: json['max_cpu'] as int,
      ram: (json['ram'] as num).toDouble(),
      maxRam: json['max_ram'] as int,
      disk: (json['disk'] as num).toDouble(),
      maxDisk: json['max_disk'] as int,
      status: json['status'] as String,
    );

Map<String, dynamic> _$StateToJson(State instance) => <String, dynamic>{
      'cpu': instance.cpu,
      'max_cpu': instance.maxCpu,
      'ram': instance.ram,
      'max_ram': instance.maxRam,
      'disk': instance.disk,
      'max_disk': instance.maxDisk,
      'status': instance.status,
    };

Server _$ServerFromJson(Map<String, dynamic> json) => Server(
      id: json['_id'] as String,
      os: json['os'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      tariffId: json['tariff_id'] as String,
      expiresAt: Server._fromJson(json['expires_at'] as int),
      status: json['status'] as String,
      numId: json['num_id'] as int,
      linkedIps:
          (json['linked_ips'] as List<dynamic>).map(LinkedIp.fromJson).toList(),
      tariffName: json['tariff_name'] as String,
      state: State.fromJson(json['state']),
    );

Map<String, dynamic> _$ServerToJson(Server instance) => <String, dynamic>{
      '_id': instance.id,
      'os': instance.os,
      'username': instance.username,
      'password': instance.password,
      'tariff_id': instance.tariffId,
      'expires_at': instance.expiresAt.toIso8601String(),
      'status': instance.status,
      'num_id': instance.numId,
      'linked_ips': instance.linkedIps,
      'tariff_name': instance.tariffName,
      'state': instance.state,
    };
