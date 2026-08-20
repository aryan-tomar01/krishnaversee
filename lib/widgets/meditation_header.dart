import 'package:flutter/material.dart';

class MeditationHeader extends StatelessWidget {
  const MeditationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.menu,
            color: Color(0xffD4A64A),
          ),
        ),

        const Spacer(),

        const Text(
          "Bhagavad Gita",
          style: TextStyle(
            color: Color(0xffD4A64A),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cinzel',
          ),
        ),

        const Spacer(),

        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications_none,
            color: Color(0xffD4A64A),
          ),
        ),
      ],
    );
  }
}