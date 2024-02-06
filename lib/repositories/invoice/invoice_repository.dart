import 'package:dio/dio.dart';
import 'package:pureservers/data/invoice/invoice.dart';

abstract class InvoiceRepository {
  final Dio dio;

  InvoiceRepository(this.dio);

  Future<List<Invoice>> getInvoices();
}
