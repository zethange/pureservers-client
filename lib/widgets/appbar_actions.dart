import 'package:flutter/material.dart';
import 'package:pureservers/core/di.dart';
import 'package:pureservers/data/user/user.dart';
import 'package:pureservers/repositories/user/user_repository.dart';

class AppBarActions extends StatefulWidget {
  const AppBarActions({super.key});

  @override
  State<StatefulWidget> createState() => _AppBarActionsState();
}

class _AppBarActionsState extends State<AppBarActions> {
  final UserRepository _repository = getIt();
  late Future<User?> _user;

  @override
  void initState() {
    super.initState();
    _user = _repository.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      FutureBuilder(
        future: _user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(
                child: Text('Не удалось получить пользователя'));
          }

          final user = snapshot.data!;
          return Text('${user.balance.toStringAsFixed(2)} ${user.currency}');
        },
      ),
      const SizedBox(width: 20)
    ]);
  }
}
