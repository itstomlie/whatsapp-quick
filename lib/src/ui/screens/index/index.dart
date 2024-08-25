import 'package:flutter/material.dart';
import 'package:send_whatsapp/provider.dart';
import 'package:send_whatsapp/src/ui/screens/history/history.dart';
import 'package:send_whatsapp/src/ui/screens/home/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Index extends ConsumerStatefulWidget {
  const Index({
    super.key,
  });

  static const routeName = '/';

  @override
  // ignore: library_private_types_in_public_api
  _IndexState createState() => _IndexState();
}

class _IndexState extends ConsumerState<Index> {
  @override
  Widget build(BuildContext context) {
    final indexBottomNavbar = ref.watch(indexBottomNavbarProvider);

    final bodies = [
      const Home(),
      const History(),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexBottomNavbar,
        onTap: (value) => ref
            .read(indexBottomNavbarProvider.notifier)
            .update((state) => value),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
      ),
      body: bodies[indexBottomNavbar],
    );
  }
}
