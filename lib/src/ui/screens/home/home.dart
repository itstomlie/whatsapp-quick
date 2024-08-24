import 'package:flutter/material.dart';
import 'package:send_whatsapp/app/data/database/message_db.dart';
import 'package:send_whatsapp/app/data/models/message.dart';
import 'package:send_whatsapp/src/ui/screens/home/widgets/form.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  static const routeName = '/';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  themeColor.background,
                  themeColor.onBackground,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/blob_bg_image.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: null /* add child content here */,
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Whatsapp Quick!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: themeColor.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Send whatsapp message without adding to contact book',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: themeColor.primary,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 40),
                      GlassmorphicContainer(
                        height: screenHeight * 0.4, // 40% of the screen height
                        width: double.infinity,
                        borderRadius: 20,
                        blur: 3,
                        alignment: Alignment.topCenter,
                        border: 0.5,
                        linearGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFFffffff).withOpacity(0.1),
                            const Color(0xFFFFFFFF).withOpacity(0.05),
                          ],
                          stops: const [0.1, 1],
                        ),
                        borderGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFFffffff).withOpacity(0.1),
                            const Color(0xFFFFFFFF).withOpacity(0.5),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 10,
                          ),
                          child: SimpleForm(onMessageSent: _getMessages),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Remove const from ListView.builder wrapper
                      GlassmorphicContainer(
                        height: 1000, // 40% of the screen height
                        width: double.infinity,
                        borderRadius: 20,
                        blur: 3,
                        alignment: Alignment.topCenter,
                        border: 0.5,
                        linearGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFFffffff).withOpacity(0.1),
                            const Color(0xFFFFFFFF).withOpacity(0.05),
                          ],
                          stops: const [0.1, 1],
                        ),
                        borderGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFFffffff).withOpacity(0.1),
                            const Color(0xFFFFFFFF).withOpacity(0.5),
                          ],
                        ),
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
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: Text('Error: ${snapshot.error}'),
                                    );
                                  } else if (!snapshot.hasData ||
                                      snapshot.data!.isEmpty) {
                                    return Text('No messages',
                                        style: TextStyle(
                                            color: themeColor.secondary));
                                  } else {
                                    final messages = snapshot.data!;
                                    return ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
