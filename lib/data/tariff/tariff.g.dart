// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tariff.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tariff _$TariffFromJson(Map<String, dynamic> json) => Tariff(
      id: json['_id'] as String,
      visibleName: json['visible_name'] as String,
      cpu: json['cpu'] as int,
      ram: json['ram'] as int,
      disk: json['disk'] as int,
      networkSpeed: json['network_speed'] as int,
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$TariffToJson(Tariff instance) => <String, dynamic>{
      '_id': instance.id,
      'visible_name': instance.visibleName,
      'cpu': instance.cpu,
      'ram': instance.ram,
      'disk': instance.disk,
      'network_speed': instance.networkSpeed,
      'price': instance.price,
    };
