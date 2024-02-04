import 'package:flutter/material.dart';
import 'package:pureservers/core/di.dart';
import 'package:pureservers/data/os/os.dart';
import 'package:pureservers/repositories/os/os_repository.dart';

class ReinstallSheet extends StatefulWidget {
  final String serverId;

  const ReinstallSheet({super.key, required this.serverId});

  @override
  State<StatefulWidget> createState() => _ReinstallSheetState();
}

class _ReinstallSheetState extends State<ReinstallSheet> {
  final OsRepository _repository = getIt();
  late Future<List<OS>> _osList;
  late String selectedOption = '';

  @override
  void initState() {
    super.initState();

    _osList = _repository.getOs(widget.serverId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      height: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Выберите систему:', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          FutureBuilder(
            future: _osList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData) {
                return const Center(
                    child: Text('Не удалось получить операционные системы'));
              }

              final osList = snapshot.data!;
              return Expanded(
                  child: ListView.builder(
                itemCount: osList.length,
                itemBuilder: (context, index) {
                  final os = osList[index];
                  return Row(children: [
                    Radio(
                      value: os.image,
                      groupValue: selectedOption,
                      onChanged: (value) {
                        debugPrint(value.toString());
                        setState(() {
                          selectedOption = value.toString();
                        });
                      },
                    ),
                    Text(os.label),
                  ]);
                },
              ));
            },
          ),
          if (selectedOption != '') const SizedBox(height: 10),
          if (selectedOption != '')
            SizedBox(
              width: 1000,
              child: FilledButton(
                onPressed: () async {
                  await _repository.reinstallOs(
                    widget.serverId,
                    selectedOption,
                  );
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                child: const Text('Переустановить'),
              ),
            ),
        ],
      ),
    );
  }
}
