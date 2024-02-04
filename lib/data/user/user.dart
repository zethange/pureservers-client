import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String firstname;
  String lastname;
  String email;
  String password;
  String currency;
  double balance;
  @JsonKey(name: "automatic_processing")
  bool automaticProcessing;
  @JsonKey(name: "is_admin")
  bool isAdmin;
  bool active;

  User({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    required this.currency,
    required this.balance,
    required this.automaticProcessing,
    required this.isAdmin,
    required this.active,
  });

  factory User.fromJson(dynamic json) {
    return _$UserFromJson(json);
  }
}
