import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: themeColor.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 70,
      width: 70,
      child: Text(
        'Q',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: themeColor.primary,
          fontWeight: FontWeight.bold,
          fontSize: 52,
        ),
      ),
    );
  }
}
