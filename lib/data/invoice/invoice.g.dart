// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invoice _$InvoiceFromJson(Map<String, dynamic> json) => Invoice(
      id: json['_id'] as String,
      userId: json['user_id'] as String,
      paymentMethod: json['payment_method'] as String,
      amount: (json['amount'] as num).toDouble(),
      status: $enumDecode(_$InvoiceStatusEnumMap, json['status']),
      userData: json['user_data'] as String?,
    );

Map<String, dynamic> _$InvoiceToJson(Invoice instance) => <String, dynamic>{
      '_id': instance.id,
      'user_id': instance.userId,
      'payment_method': instance.paymentMethod,
      'amount': instance.amount,
      'status': _$InvoiceStatusEnumMap[instance.status]!,
      'user_data': instance.userData,
    };

const _$InvoiceStatusEnumMap = {
  InvoiceStatus.PAID: 'paid',
  InvoiceStatus.WAITING: 'waiting',
};
