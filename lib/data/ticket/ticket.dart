import 'package:json_annotation/json_annotation.dart';

part 'ticket.g.dart';

@JsonSerializable()
class Ticket {
  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'user_id')
  String userId;

  String subject;
  String status;

  Ticket({
    required this.id,
    required this.userId,
    required this.subject,
    required this.status,
  });

  factory Ticket.fromJson(dynamic json) {
    return _$TicketFromJson(json);
  }
}

@JsonSerializable()
class Message {
  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'ticket_id')
  String ticketId;

  @JsonKey(name: 'from_id')
  String fromId;

  @JsonKey(name: 'from_type')
  String fromType;

  String text;

  Message({
    required this.id,
    required this.ticketId,
    required this.fromId,
    required this.fromType,
    required this.text,
  });

  factory Message.fromJson(dynamic json) {
    return _$MessageFromJson(json);
  }
}

@JsonSerializable()
class FullTicket {
  Ticket ticket;
  List<Message> messages;

  FullTicket({
    required this.ticket,
    required this.messages,
  });

  factory FullTicket.fromJson(dynamic json) {
    return _$FullTicketFromJson(json);
  }
}
