import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/routes_name.dart';
import 'profile_setting_tile.dart';

class SecurityPrivacy extends StatefulWidget {
  const SecurityPrivacy({super.key});

  @override
  State<SecurityPrivacy> createState() => _SecurityPrivacyState();
}

class _SecurityPrivacyState extends State<SecurityPrivacy> {
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
          "Security & Privacy",
          style: TextStyle(
            color: Color(0xffD4AF37),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "ACCOUNT SECURITY",
              style: TextStyle(
                color: Color(0xffD4AF37),
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              decoration: BoxDecoration(
                color: const Color(0xff1B3767),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [

                  ProfileSettingTile(
                    icon: Icons.lock_outline,
                    title: "Change Password",
                    onTap: () {
                      Get.toNamed(RouteName.changePassword);
                    },
                  ),

                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "PRIVACY",
              style: TextStyle(
                color: Color(0xffD4AF37),
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              decoration: BoxDecoration(
                color: const Color(0xff1B3767),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [

                  ProfileSettingTile(
                    icon: Icons.privacy_tip_outlined,
                    title: "Privacy Policy",
                    onTap: () {
                      Get.toNamed(RouteName.privacyPolicy);
                    },
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}