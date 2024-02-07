// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticket _$TicketFromJson(Map<String, dynamic> json) => Ticket(
      id: json['_id'] as String,
      userId: json['user_id'] as String,
      subject: json['subject'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
      '_id': instance.id,
      'user_id': instance.userId,
      'subject': instance.subject,
      'status': instance.status,
    };

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['_id'] as String,
      ticketId: json['ticket_id'] as String,
      fromId: json['from_id'] as String,
      fromType: json['from_type'] as String,
      text: json['text'] as String,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      '_id': instance.id,
      'ticket_id': instance.ticketId,
      'from_id': instance.fromId,
      'from_type': instance.fromType,
      'text': instance.text,
    };

FullTicket _$FullTicketFromJson(Map<String, dynamic> json) => FullTicket(
      ticket: Ticket.fromJson(json['ticket']),
      messages:
          (json['messages'] as List<dynamic>).map(Message.fromJson).toList(),
    );

Map<String, dynamic> _$FullTicketToJson(FullTicket instance) =>
    <String, dynamic>{
      'ticket': instance.ticket,
      'messages': instance.messages,
    };
