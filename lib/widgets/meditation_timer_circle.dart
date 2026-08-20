import 'package:flutter/material.dart';

class MeditationTimerCircle extends StatelessWidget {
  const MeditationTimerCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 260,
        height: 260,
        child: Stack(
          alignment: Alignment.center,
          children: [

            Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFD4A64A),
                  width: 2,
                ),
              ),
            ),

            Container(
              width: 235,
              height: 235,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFD4A64A),
                  width: 2,
                ),
              ),
            ),

            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(
                  "15:00",
                  style: TextStyle(
                    color: Color(0xFFD4A64A),
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 6),

                Text(
                  "REMAINING",
                  style: TextStyle(
                    color: Colors.white70,
                    letterSpacing: 2,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}