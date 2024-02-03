import 'package:json_annotation/json_annotation.dart';

part 'os.g.dart';

@JsonSerializable()
class OS {
  String label;
  String image;

  OS({
    required this.label,
    required this.image,
  });

  factory OS.fromJson(dynamic json) {
    return _$OSFromJson(json);
  }
}
