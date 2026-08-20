import 'package:flutter/material.dart';
import 'package:krishnaversee/screens/dailystreak_screen.dart';
import '../widgets/journey_card.dart';
import 'dailywisdom_screen.dart';

class JourneyAhead extends StatelessWidget {
  const JourneyAhead({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "Journey Ahead",
            style: TextStyle(
              fontFamily: 'Inter-bold',
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xff142B56),
            ),
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              Expanded(
                child: JourneyCard(
                  icon: Icons.auto_awesome,
                  title: "Daily Wisdom",
                  iconColor: Colors.white,
                  subtitle: "Read today's wisdom",
                  cardColor: const Color(0xffD6AE43),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const DailyWisdomScreen()),
                    );
                  },
                ),
              ),

              const SizedBox(width: 15),

              Expanded(
                child: JourneyCard(
                  icon: Icons.local_fire_department,
                  iconColor: Colors.orange,
                  title: "Daily Streak",
                  subtitle: "Keep your Spiritual journey alive!",
                  cardColor: const Color(0xff1D2743),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const DailyStreakScreen()),
                    );
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}