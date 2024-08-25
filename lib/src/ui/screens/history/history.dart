import 'package:flutter/material.dart';
import 'package:send_whatsapp/app/data/database/message_db.dart';
import 'package:send_whatsapp/app/data/models/message.dart';
import 'package:intl/intl.dart';
import 'package:send_whatsapp/src/ui/screens/history/historyDetail.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();

  static const routeName = '/history';
}

class _HistoryState extends State<History> {
  Future<List<Message>>? _messages;
  final messageDB = MessageDB();

  Future<void> _getMessages() async {
    setState(() {
      _messages = messageDB.getMessages();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getMessages(); // Trigger fetch when switching to this screen
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme;

    return Container(
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(color: themeColor.background),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Ensure content is aligned to the start
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 24, 12, 0),
            child: Column(
              children: [
                Text(
                  'History',
                  style: TextStyle(
                    color: themeColor.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
                const Divider(
                  height: 10,
                  thickness: 1,
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Message>>(
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
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];

                      String date = DateFormat('dd MMM yy')
                          .format(message.createdAt.toLocal());
                      String time = DateFormat('HH:mm:ss')
                          .format(message.createdAt.toLocal());

                      return ListTile(
                        onTap: () {
                          if (message.body?.isNotEmpty == true) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    HistoryDetail(message: message),
                              ),
                            );
                          }
                        },
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              message.number,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '$date, $time',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        subtitle: SizedBox(
                          height: 30,
                          child: Text(
                            message.body?.isNotEmpty == true
                                ? message.body!
                                : '[No Message]',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        trailing: message.body?.isNotEmpty == true
                            ? const SizedBox(
                                width: 35,
                                child: Center(
                                  child: Icon(Icons.info),
                                ),
                              )
                            : const SizedBox(width: 60),
                        isThreeLine: message.body?.isNotEmpty == true,
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
