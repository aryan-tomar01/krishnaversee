import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class DailyWisdomScreen extends StatelessWidget {
  const DailyWisdomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff10131F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xffD9D8F9)),
        title: const Text(
          "Daily Wisdom",
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
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.white.withValues(alpha: 0.5)),
                const SizedBox(width: 8),
                Text(
                  _formattedDate(),
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xffD6AE43), Color(0xffB8863A)],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xffD6AE43).withValues(alpha: 0.25),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.auto_awesome, color: Colors.white, size: 30),
                  const SizedBox(height: 18),
                  const Text(
                    '"शांति भीतर से आती है। इसे बाहर मत खोजो।"',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 1,
                        color: Colors.white70,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "कृष्ण 🦚",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xff1D2743),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white12),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.self_improvement, size: 16, color: Color(0xffD6AE43)),
                  SizedBox(width: 6),
                  Text(
                    "Inner Peace",
                    style: TextStyle(color: Color(0xffD9D8F9), fontSize: 13),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            _ActionButton(
              icon: Icons.share_outlined,
              label: "Share",
              onTap: () {
                Share.share(
                  '"शांति भीतर से आती है। इसे बाहर मत खोजो।"\n— कृष्ण 🦚,\n\nDaily Wisdom App',
                  subject: "Today's Wisdom",
                );
              },
            ),

            const SizedBox(height: 30),

            const Text(
              "Reflection",
              style: TextStyle(
                color: Color(0xffD9D8F9),
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Take a moment today to sit quietly and notice your breath. "
                  "True calm isn't found in circumstances outside you — it grows "
                  "from stillness cultivated within.",
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 14,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  String _formattedDate() {
    const months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    final now = DateTime.now();
    return "${months[now.month - 1]} ${now.day}, ${now.year}";
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xff1D2743),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xffD9D8F9), size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(color: Color(0xffD9D8F9), fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}