import 'package:flutter/material.dart';

class DailyStreakScreen extends StatelessWidget {
  const DailyStreakScreen({super.key});

  // Sample data — replace with real streak data from your backend/local storage
  static const int currentStreak = 7;
  static const int bestStreak = 21;
  static const List<bool> weekProgress = [
    true, true, true, true, true, true, false
  ]; // Mon..Sun, false = not completed yet

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff10131F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xffD9D8F9)),
        title: const Text(
          "Daily Streak",
          style: TextStyle(
            color: Color(0xffD9D8F9),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Streak hero card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 36),
              decoration: BoxDecoration(
                color: const Color(0xff1D2743),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white12),
              ),
              child: Column(
                children: [
                  Container(
                    width: 84,
                    height: 84,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orange.withValues(alpha: 0.15),
                    ),
                    child: const Icon(
                      Icons.local_fire_department,
                      color: Colors.orange,
                      size: 46,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "$currentStreak",
                    style: const TextStyle(
                      color: Color(0xffD9D8F9),
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Day Streak",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Keep your spiritual journey alive! 🔥",
                    style: TextStyle(
                      color: Color(0xffD6AE43),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              "This Week",
              style: TextStyle(
                color: Color(0xffD9D8F9),
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Week progress dots
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (index) {
                const labels = ["M", "T", "W", "T", "F", "S", "S"];
                final done = weekProgress[index];
                return Column(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: done
                            ? const Color(0xffD6AE43)
                            : const Color(0xff1D2743),
                        border: Border.all(
                          color: done ? const Color(0xffD6AE43) : Colors.white24,
                        ),
                      ),
                      child: Icon(
                        done ? Icons.check : Icons.circle,
                        size: done ? 18 : 6,
                        color: done ? Colors.white : Colors.white24,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      labels[index],
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 12,
                      ),
                    ),
                  ],
                );
              }),
            ),

            const SizedBox(height: 32),

            // Stats row
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    icon: Icons.emoji_events_outlined,
                    label: "Best Streak",
                    value: "$bestStreak days",
                    color: const Color(0xffD6AE43),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _StatCard(
                    icon: Icons.check_circle_outline,
                    label: "Total Days",
                    value: "128 days",
                    color: Colors.greenAccent,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              "Milestones",
              style: TextStyle(
                color: Color(0xffD9D8F9),
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            _MilestoneTile(days: 7, achieved: currentStreak >= 7),
            _MilestoneTile(days: 14, achieved: currentStreak >= 14),
            _MilestoneTile(days: 30, achieved: currentStreak >= 30),
            _MilestoneTile(days: 100, achieved: currentStreak >= 100),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xff1D2743),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xffD9D8F9),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _MilestoneTile extends StatelessWidget {
  final int days;
  final bool achieved;

  const _MilestoneTile({required this.days, required this.achieved});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xff1D2743),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: achieved ? const Color(0xffD6AE43) : Colors.white12,
        ),
      ),
      child: Row(
        children: [
          Icon(
            achieved ? Icons.workspace_premium : Icons.lock_outline,
            color: achieved ? const Color(0xffD6AE43) : Colors.white24,
            size: 22,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              "$days Day Streak",
              style: TextStyle(
                color: achieved ? const Color(0xffD9D8F9) : Colors.white38,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (achieved)
            const Icon(Icons.check_circle, color: Color(0xffD6AE43), size: 18),
        ],
      ),
    );
  }
}
