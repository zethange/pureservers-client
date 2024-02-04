// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      currency: json['currency'] as String,
      balance: (json['balance'] as num).toDouble(),
      automaticProcessing: json['automatic_processing'] as bool,
      isAdmin: json['is_admin'] as bool,
      active: json['active'] as bool,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'email': instance.email,
      'password': instance.password,
      'currency': instance.currency,
      'balance': instance.balance,
      'automatic_processing': instance.automaticProcessing,
      'is_admin': instance.isAdmin,
      'active': instance.active,
    };
