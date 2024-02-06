import 'package:json_annotation/json_annotation.dart';

part 'invoice.g.dart';

enum InvoiceStatus {
  @JsonValue("paid")
  PAID,
  @JsonValue("waiting")
  WAITING,
}

@JsonSerializable()
class Invoice {
  @JsonKey(name: "_id")
  String id;

  @JsonKey(name: "user_id")
  String userId;

  @JsonKey(name: "payment_method")
  String paymentMethod;

  double amount;
  InvoiceStatus status;

  @JsonKey(name: "user_data")
  String? userData;

  Invoice({
    required this.id,
    required this.userId,
    required this.paymentMethod,
    required this.amount,
    required this.status,
    this.userData,
  });

  factory Invoice.fromJson(dynamic json) {
    return _$InvoiceFromJson(json);
  }
}
