import 'package:dio/src/dio.dart';
import 'package:pureservers/core/config.dart';
import 'package:pureservers/data/invoice/invoice.dart';
import 'package:pureservers/repositories/invoice/invoice_repository.dart';

class InvoiceRepositoryImpl implements InvoiceRepository {
  @override
  final Dio dio;

  InvoiceRepositoryImpl(this.dio);

  @override
  Future<List<Invoice>> getInvoices() async {
    final res = await dio.get('${AppConfig.apiUrl}/invoices/list');
    return (res.data as List).map((e) => Invoice.fromJson(e)).toList();
  }
}
