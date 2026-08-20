import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 22, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xffD4AF37),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget sectionText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 15,
        height: 1.6,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff142B56),

      appBar: AppBar(
        backgroundColor: const Color(0xff142B56),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xffD4AF37),
          ),
        ),
        title: const Text(
          "Privacy Policy",
          style: TextStyle(
            color: Color(0xffD4AF37),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xff1B3767),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Center(
                child: Icon(
                  Icons.privacy_tip_outlined,
                  size: 55,
                  color: Color(0xffD4AF37),
                ),
              ),

              const SizedBox(height: 15),

              const Center(
                child: Text(
                  "Your Privacy Matters",
                  style: TextStyle(
                    color: Color(0xffD4AF37),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              sectionTitle("1. Information We Collect"),

              sectionText(
                "KrishnaVerse collects only the information required to provide a secure and personalized experience, such as your name, email address, and account details.",
              ),

              sectionTitle("2. How We Use Your Information"),

              sectionText(
                "Your information is used only for account authentication, saving your reading progress, and improving your overall experience within the app.",
              ),

              sectionTitle("3. Data Security"),

              sectionText(
                "We take reasonable measures to protect your personal information. Your login credentials are securely managed through Firebase Authentication.",
              ),

              sectionTitle("4. Third-Party Services"),

              sectionText(
                "KrishnaVerse may use trusted services such as Firebase to provide authentication and cloud-based features. These services have their own privacy policies.",
              ),

              sectionTitle("5. Contact Us"),

              sectionText(
                "If you have any questions regarding this Privacy Policy, you can contact us through the Contact Us section available in the application.",
              ),

              const SizedBox(height: 30),

              const Center(
                child: Text(
                  "Last Updated: July 2026",
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}