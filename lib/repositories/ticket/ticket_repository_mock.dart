import 'package:dio/dio.dart';
import 'package:pureservers/data/status.dart';
import 'package:pureservers/data/ticket/ticket.dart';
import 'package:pureservers/repositories/ticket/ticket_repository.dart';

class TicketRepositoryMock implements TicketRepository {
  @override
  final Dio dio;

  TicketRepositoryMock(this.dio);

  @override
  Future<List<Ticket>> getTickets() async {
    return [
      Ticket(
          id: "1", userId: "1", subject: "Жить или не жить", status: "waiting")
    ];
  }

  @override
  Future<FullTicket> getTicketById(String ticketId) async {
    return FullTicket(
      ticket: Ticket(
        subject: 'Жить или не жить',
        status: 'waiting',
        id: '1',
        userId: '1',
      ),
      messages: [
        Message(
          id: '1',
          ticketId: '1',
          fromId: '1',
          fromType: 'client',
          text: 'Памагите',
        ),
        Message(
          id: '2',
          ticketId: '1',
          fromId: '2',
          fromType: 'support',
          text: 'Тебе уже ничего не поможет',
        ),
      ],
    );
  }

  @override
  Future<Status> sendMessageToTicketById(String ticketId, String text) async {
    return Status(success: true, message: '');
  }
}
