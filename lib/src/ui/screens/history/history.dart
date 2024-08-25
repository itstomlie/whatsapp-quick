import 'package:flutter/material.dart';
import 'package:send_whatsapp/app/data/database/message_db.dart';
import 'package:send_whatsapp/app/data/models/message.dart';
import 'package:intl/intl.dart';

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
      height: 1000,
      width: double.infinity,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(color: themeColor.background),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Ensure content is aligned to the start
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
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

                      String date =
                          DateFormat('dd').format(message.createdAt.toLocal());
                      String month =
                          DateFormat('MMM').format(message.createdAt.toLocal());
                      String year =
                          DateFormat('yy').format(message.createdAt.toLocal());

                      String time = DateFormat('HH:mm:ss')
                          .format(message.createdAt.toLocal());

                      return ListTile(
                        leading: SizedBox(
                          width: 60,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(date),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(month),
                                  const SizedBox(width: 5),
                                  Text(year),
                                ],
                              )
                            ],
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
                              time,
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
                        isThreeLine: true,
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
