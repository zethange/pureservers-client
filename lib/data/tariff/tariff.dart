import 'package:json_annotation/json_annotation.dart';

part 'tariff.g.dart';

@JsonSerializable()
class Tariff {
  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'visible_name')
  String visibleName;
  int cpu;
  int ram;
  int disk;

  @JsonKey(name: 'network_speed')
  int networkSpeed;
  double price;

  Tariff({
    required this.id,
    required this.visibleName,
    required this.cpu,
    required this.ram,
    required this.disk,
    required this.networkSpeed,
    required this.price,
  });

  factory Tariff.fromJson(dynamic json) {
    return _$TariffFromJson(json);
  }
}
