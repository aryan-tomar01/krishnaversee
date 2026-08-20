import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class HelpFaqScreen extends StatefulWidget{
  const HelpFaqScreen({super.key});

  @override
  State<HelpFaqScreen> createState() => _HelpFaqScreenState();
}

class _HelpFaqScreenState extends State<HelpFaqScreen> {

  Widget faqTile(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xff1B3767),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ExpansionTile(
        iconColor: const Color(0xffD4AF37),
        collapsedIconColor: const Color(0xffD4AF37),
        title: Text(
          question,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          Text(
            answer,
            style: const TextStyle(
              color: Colors.white70,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff142B56),
      appBar: AppBar(
        backgroundColor:  const Color(0xff1B3767),
        title: Text('HELP & FAQ', style: TextStyle(
          color: Color(0xffD4AF37),
          fontWeight: FontWeight.bold,
        ),),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios,
            color: Color(0xffD4AF37),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            faqTile("How do I create an account?",
                "Tap on the Sign Up button, enter your name, email address, and password, then create your account to start your spiritual journey."),
            faqTile("I forgot my password. What should I do?",
                "Tap on Forgot Password on the login screen and follow the instructions sent to your registered email address."),
            faqTile("Does KrishnaVerse require an internet connection?",
                "Reading chapters requires an internet connection initially. Some downloaded content and saved progress may be available offline."),
            faqTile("Is my reading progress saved?",
                "Yes. Your reading progress and daily streak are securely saved to your account so you can continue anytime."),
            faqTile("How does the Daily Streak work?",
                "Open KrishnaVerse every day and read at least one verse or chapter to maintain your daily spiritual streak."),
            faqTile("Can I listen to Bhagavad Gita audio?",
                "Yes. KrishnaVerse provides audio playback for Bhagavad Gita chapters, allowing you to listen while studying or meditating."),
            faqTile("How can I contact support?",
                "Visit the About Us section from your profile and send us your questions or feedback."),
            faqTile("Is KrishnaVerse free to use?",
                "Yes. KrishnaVerse is free to use. Additional features may be introduced in future updates.")
          ],
        ),
      ),
    );
  }
}