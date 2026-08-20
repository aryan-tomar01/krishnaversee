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
            color: Color(0xffD4A64A),
            fontSize: 38,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 10),

        Text(
          "\"Fixed in Yoga, perform your actions\"",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}