import 'package:flutter/material.dart';

class MeditationTitle extends StatelessWidget {
  const MeditationTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          "Meditation Timer",
          style: TextStyle(
            color: Color(0xFFD4A64A),
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 8),

        Text(
          "\"Fixed in Yoga, perform your actions\"",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}