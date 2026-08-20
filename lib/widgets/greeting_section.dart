import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GreetingSection extends StatelessWidget {
  const GreetingSection({super.key});

  // ================= GREETING =================

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "सुप्रभात ☀️🙏";
    } else if (hour < 17) {
      return "शुभ दोपहर 🌤️🙏";
    } else {
      return "शुभ संध्या 🌑🙏";
    }
  }

  // ================= SUBTITLE =================

  String getSubtitle() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Start your day with peace.";
    } else if (hour < 17) {
      return "Take a mindful break.";
    } else {
      return "Relax and unwind.";
    }
  }

  @override
  Widget build(BuildContext context) {
    // ================= CURRENT FIREBASE USER =================

    final User? user = FirebaseAuth.instance.currentUser;

    // Get name from Firebase
    final String userName =
    user?.displayName?.trim().isNotEmpty == true
        ? user!.displayName!
        : "User";

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= GREETING =================

              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  getGreeting(),
                  style: const TextStyle(
                    fontSize: 23,
                    color: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 2),

              // ================= USER NAME =================

              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 5),

              // ================= SUBTITLE =================

              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  getSubtitle(),
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
        ),

        // ================= NOTIFICATION =================

        InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {},

          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 20),

                decoration: BoxDecoration(
                  color: Colors.white.withValues(
                    alpha: 0.08,
                  ),
                  shape: BoxShape.circle,
                ),

                child: const Icon(
                  Icons.notifications_none_rounded,
                  size: 28,
                ),
              ),

              // ================= NOTIFICATION DOT =================

              Positioned(
                right: 2,
                top: 2,

                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 15.0,
                  ),

                  child: Container(
                    width: 10,
                    height: 10,

                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}