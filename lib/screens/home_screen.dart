import 'package:flutter/material.dart';
import 'package:krishnaversee/screens/bottom_nav_bar.dart';
import 'package:krishnaversee/screens/continue_reading.dart';
import 'package:krishnaversee/screens/journey_ahead.dart';
import 'package:krishnaversee/screens/verse_card.dart';
import 'package:krishnaversee/utils/app_colors.dart';
import '../widgets/greeting_section.dart';
import '../widgets/glowing_spa_button.dart';
import '../widgets/quick_sadhana_sheet.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const GreetingSection(),
              const SizedBox(height: 20),
              const VerseCard(),
              const SizedBox(height: 20),
              const ContinueReading(),
              const SizedBox(height: 20),
              JourneyAhead(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      bottomNavigationBar:  BottomNavBar(),
      floatingActionButton: GlowingSpaButton(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return  QuickSadhanaSheet();
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}