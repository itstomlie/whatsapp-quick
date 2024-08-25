import 'package:flutter/material.dart';
import 'package:send_whatsapp/app/data/database/message_db.dart';
import 'package:send_whatsapp/app/data/models/message.dart';
import 'package:send_whatsapp/provider.dart';
import 'package:send_whatsapp/src/ui/screens/home/widgets/form.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod

class Home extends ConsumerStatefulWidget {
  const Home({
    super.key,
  });

  static const routeName = '/';

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  Future<List<Message>>? _messages;
  final messageDB = MessageDB();

  @override
  void initState() {
    super.initState();
    _getMessages();
  }

  Future<void> _getMessages() async {
    setState(() {
      _messages = messageDB.getMessages();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme;

    final indexBottomNavbar =
        ref.watch(indexBottomNavbarProvider); // Watch the provider

    final bodies = [
      Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(color: themeColor.background),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(100.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: themeColor.secondary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 60,
                        width: 60,
                        child: Text(
                          'Q',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: themeColor.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 48,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                        color: themeColor.onBackground,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Whatsapp Quick!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: themeColor.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Send whatsapp message without adding to contacts',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: themeColor.primary,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 18),
                            SimpleForm(onMessageSent: _getMessages),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      Container(
        height: 1000, // Adjust as needed
        width: double.infinity,
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(color: themeColor.background),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: Column(
            children: [
              Text(
                'History',
                style: TextStyle(
                  color: themeColor.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const Divider(
                height: 10,
                thickness: 1,
              ),
              FutureBuilder<List<Message>>(
                future: _messages,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No messages',
                        style: TextStyle(color: themeColor.secondary));
                  } else {
                    final messages = snapshot.data!;
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        return ListTile(
                          leading: const SizedBox(
                            width: 20, // Adjust width as needed
                            child: Center(
                              child: Icon(Icons.flag_sharp),
                            ),
                          ),
                          title: Text(
                            message.number,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                message.createdAt.toString(),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(
                                height: 30,
                                child: Text(
                                  message.body ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          trailing: const SizedBox(
                            width: 20, // Adjust width as needed
                            child: Center(
                              child: Icon(Icons.chevron_right),
                            ),
                          ),
                          isThreeLine: true,
                        );
                      },
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexBottomNavbar, // Set the current index
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
