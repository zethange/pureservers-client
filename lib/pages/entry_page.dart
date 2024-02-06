import 'package:flutter/material.dart';
import 'package:pureservers/pages/account_page.dart';
import 'package:pureservers/pages/home_page.dart';
import 'package:pureservers/pages/support_page.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({super.key});

  @override
  State<StatefulWidget> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  final pages = const [HomePage(), SupportPage(), AccountPage()];
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (value) => {
          setState(() => currentPageIndex = value),
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.storage),
            label: 'Серверы',
          ),
          NavigationDestination(
            icon: Icon(Icons.psychology),
            label: 'Тикеты',
          ),
          NavigationDestination(icon: Icon(Icons.person), label: 'Аккаунт')
        ],
      ),
    );
  }
}
