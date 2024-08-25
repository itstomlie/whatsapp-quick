import 'package:flutter/material.dart';
import 'package:send_whatsapp/app/data/database/message_db.dart';
import 'package:send_whatsapp/app/data/models/message.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<void> safeLaunchUrl(Uri uri) async {
  try {
    final bool launched = await launchUrl(uri);
    if (!launched) {
      // Handle the fact that the launch was not successful
      throw 'Failed to launch $uri'; // `throw could not launch` is used for error handling
    }
  } on Exception catch (e) {
    // TODO: Show a dialog with the error message or log the error
    print(e.toString());
  }
}

class SimpleForm extends StatefulWidget {
  const SimpleForm({super.key});

  @override
  State<SimpleForm> createState() => _SimpleFormState();
}

class _SimpleFormState extends State<SimpleForm> {
  final _formKey = GlobalKey<FormState>();
  final _numberController = TextEditingController();
  final _messageController = TextEditingController();

  final messageDB = MessageDB();
  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme;

    return Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _numberController,
                    keyboardType: TextInputType.phone,
                    // autofocus: true,
                    cursorColor: themeColor.primary,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone,
                        color: themeColor.primary,
                      ),
                      hintText: '+6285273495013',
                      hintStyle: TextStyle(color: themeColor.primary),
                      label: RichText(
                        text: TextSpan(
                            text: 'Whatsapp Number',
                            style: TextStyle(color: themeColor.primary),
                            children: [
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                    color: themeColor.error,
                                  ))
                            ]),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        borderSide:
                            BorderSide(color: themeColor.primary, width: 0.0),
                      ),
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: themeColor.primary, width: 2.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Whatsapp number is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    maxLines: 15,
                    minLines: 5,
                    keyboardType: TextInputType.multiline,
                    controller: _messageController,
                    cursorColor: themeColor.primary,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.message,
                        color: themeColor.primary,
                      ),
                      hintText: 'Your Message (Optional)',
                      label: Text(
                        'Message (Optional)',
                        style: TextStyle(
                          color: themeColor.primary,
                          fontSize: 14,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        borderSide:
                            BorderSide(color: themeColor.primary, width: 0.0),
                      ),
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: themeColor.primary, width: 2.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                      foregroundColor: themeColor.primary,
                      backgroundColor: themeColor.secondary,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var uri = Uri.parse(
                            'https://wa.me/${_numberController.text}?text=${Uri.encodeComponent(_messageController.text)}');

                        safeLaunchUrl(uri);

                        final newMessage = Message.create(
                            _numberController.text,
                            _messageController.text,
                            DateTime.now());

                        await messageDB.insertMessage(newMessage);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.paperPlane,
                          color: themeColor.onSurface,
                          size: 15.0,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Send',
                          style: TextStyle(
                            color: themeColor.onSurface,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
