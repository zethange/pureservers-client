import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pureservers/core/di.dart';
import 'package:pureservers/data/invoice/invoice.dart';
import 'package:pureservers/repositories/invoice/invoice_repository.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({
    super.key,
  });

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  final InvoiceRepository _invoiceRepository = getIt();
  late Future<List<Invoice>> _invoiceList;

  @override
  void initState() {
    super.initState();

    _invoiceList = _invoiceRepository.getInvoices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Платежи"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _invoiceList = _invoiceRepository.getInvoices();
          });
        },
        child: FutureBuilder(
          future: _invoiceList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData) return const Text('Нет данных');

            final data = snapshot.data!;
            return DataTable(
              columns: const [
                DataColumn(label: Text('Статус')),
                DataColumn(label: Text('Способ')),
                DataColumn(label: Text('Сумма')),
              ],
              rows: data
                  .map((e) => DataRow(cells: [
                        DataCell(SelectableText(e.status.toString())),
                        DataCell(SelectableText(e.paymentMethod)),
                        DataCell(SelectableText(e.amount.toString()))
                      ]))
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
