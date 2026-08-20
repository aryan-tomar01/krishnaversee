import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class VerseCard extends StatelessWidget {
  const VerseCard({super.key});

  static const String _shareText =
      "कर्मण्येवाधिकारस्ते मा फलेषु कदाचन ।\n"
      "मा कर्मफलहेतुर्भूर्मा ते सङ्गोऽस्त्वकर्मणि ॥\n\n"
      "\"You have a right to perform your prescribed duties, "
      "but you are not entitled to the fruits of your actions.\"\n\n"
      "- Bhagavad Gita 2.47";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Ink(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 24,
        ),

        decoration: BoxDecoration(
          color: const Color(0xff142B56),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .25),
              blurRadius: 12,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.amber.withValues(alpha: .35),
                    thickness: 1,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  "VERSE OF THE DAY",
                  style: TextStyle(
                    color: Color(0xffF2C14E),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Divider(
                    color: Colors.amber.withValues(alpha: .35),
                    thickness: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            const Text(
              "कर्मण्येवाधिकारस्ते मा फलेषु\n"
                  "कदाचन ।\n"
                  "मा कर्मफलहेतुर्भूर्मा ते\n"
                  "सङ्गोऽस्त्वकर्मणि ॥",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xffF7C948),
                fontSize: 28,
                height: 1.6,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              '"You have a right to perform your\n'
                  'prescribed duties, but you are not\n'
                  'entitled to the fruits of your\n'
                  'actions."',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 18,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 18),
            const Divider(
              color: Colors.white24,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ActionButton(
                  icon: Icons.share_outlined,
                  title: "SHARE",
                  onTap: () {
                    Share.share(_shareText);
                  },
                ),
                _ActionButton(
                  icon: Icons.bookmark_border,
                  title: "SAVE",
                  onTap: () {
                  },
                ),
                _ActionButton(
                  icon: Icons.play_circle_outline,
                  title: "LISTEN",
                  onTap: () {
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 11,
                letterSpacing: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}