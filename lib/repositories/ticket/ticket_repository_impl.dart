import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pureservers/core/config.dart';
import 'package:pureservers/data/status.dart';
import 'package:pureservers/data/ticket/ticket.dart';
import 'package:pureservers/repositories/ticket/ticket_repository.dart';

class TicketRepositoryImpl implements TicketRepository {
  @override
  final Dio dio;

  TicketRepositoryImpl(this.dio);

  @override
  Future<List<Ticket>> getTickets() async {
    final res = await dio.get('${AppConfig.apiUrl}/tickets/list');
    return (res.data as List).map((e) => Ticket.fromJson(e)).toList();
  }

  @override
  Future<FullTicket> getTicketById(String ticketId) async {
    final res = await dio.post(
      '${AppConfig.apiUrl}/tickets/view',
      data: jsonEncode(ticketId),
    );

    return FullTicket.fromJson(res.data);
  }

  @override
  Future<Status> sendMessageToTicketById(String ticketId, String text) async {
    await dio.post(
      '${AppConfig.apiUrl}/tickets/send',
      data: jsonEncode({'text': text, 'ticket_id': ticketId}),
    );

    return Status(success: true, message: '');
  }
}
