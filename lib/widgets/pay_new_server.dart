import 'package:flutter/material.dart';
import 'package:pureservers/core/di.dart';
import 'package:pureservers/data/tariff/tariff.dart';
import 'package:pureservers/repositories/tariff_repository.dart';

class PayNewServerBottomSheet extends StatefulWidget {
  const PayNewServerBottomSheet({super.key});

  @override
  PayNewServerBottomSheetState createState() => PayNewServerBottomSheetState();
}

class PayNewServerBottomSheetState extends State<PayNewServerBottomSheet> {
  final TariffRepository _repository = getIt();
  late Future<List<Tariff>> _tariffs;
  bool _selected = false;
  late Tariff _selectedTariff;

  @override
  void initState() {
    super.initState();
    _tariffs = _repository.getTariffs();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      height: 600,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Выберите тариф:', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 10),
        FutureBuilder(
          future: _tariffs,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData) {
              return const Center(child: Text('Не удалось получить тарифы'));
            }

            final tariffs = snapshot.data!;
            return Expanded(
                child: ListView.builder(
              itemCount: tariffs.length,
              itemBuilder: (context, index) {
                final tariff = tariffs[index];

                return Card(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selected = true;
                        _selectedTariff = tariff;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tariff.visibleName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          Row(children: [
                            const Text('vCPU:'),
                            const Spacer(),
                            Text(tariff.cpu.toString()),
                          ]),
                          const SizedBox(height: 5),
                          Row(children: [
                            const Text('RAM:'),
                            const Spacer(),
                            Text('${tariff.ram} ГБ'),
                          ]),
                          const SizedBox(height: 5),
                          Row(children: [
                            const Text('Дисковое пространство:'),
                            const Spacer(),
                            Text('${tariff.disk} ГБ'),
                          ]),
                          const SizedBox(height: 5),
                          Row(children: [
                            const Text('Скорость сети:'),
                            const Spacer(),
                            Text('${tariff.networkSpeed} Мбит/с'),
                          ]),
                          const SizedBox(height: 5),
                          Row(children: [
                            const Text('Стоимость:'),
                            const Spacer(),
                            Text('${tariff.price} EUR'),
                          ]),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ));
          },
        ),
        if (_selected) const SizedBox(height: 10),
        if (_selected)
          Row(children: [
            Text(
              '${_selectedTariff.visibleName}, будет списано: ${_selectedTariff.price} EUR',
            ),
            const Spacer(),
            FilledButton(onPressed: () {}, child: const Text('Купить'))
          ]),
      ]),
    );
  }
}
