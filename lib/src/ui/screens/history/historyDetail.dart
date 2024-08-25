import 'package:flutter/material.dart';
import 'package:send_whatsapp/app/data/models/message.dart';
import 'package:intl/intl.dart';

class HistoryDetail extends StatelessWidget {
  final Message message;

  const HistoryDetail({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme;

    String date = DateFormat('dd MMM yy').format(message.createdAt.toLocal());
    String time = DateFormat('HH:mm:ss').format(message.createdAt.toLocal());

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(color: themeColor.background),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Message Detail',
                            style: TextStyle(
                              color: themeColor.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 48, // Same width as the IconButton
                      ),
                    ],
                  ),
                  const Divider(
                    height: 10,
                    thickness: 1,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
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
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    message.body ?? '[No Message]',
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
