import 'package:flutter/material.dart';
import 'package:send_whatsapp/src/ui/screens/home/components/logo.dart';
import 'package:send_whatsapp/src/ui/screens/home/widgets/form.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme;

    return Stack(
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
                  const SizedBox(height: 90),
                  const Logo(),
                  const SizedBox(height: 90),
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
                          const SimpleForm(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
