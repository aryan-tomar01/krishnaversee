import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishnaversee/view/profile/profile_setting_tile.dart';
import '../../routes/routes_name.dart';

class ProfileScreen extends StatefulWidget{
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff142B56),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [

              SizedBox(height: 55),
              Text('"उद्धरेदात्मनात्मानं नात्मानमवसादयेत्।\n'
                  'आत्मैव ह्यात्मनो बन्धुरात्मैव रिपुरात्मनः॥" ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xffD4AF37),
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),

              Text(
                "Bhagavad Gita • Chapter 6 Verse 5",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),

              SizedBox(height: 40),

              Row(
                children: [

                  Expanded(
                    child: Divider(
                      color: const Color(0xffD4AF37).withValues(alpha: 0.3),
                      thickness: 1,
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Icon(
                      Icons.favorite,
                      color: Color(0xffD4AF37),
                      size: 14,
                    ),
                  ),

                  Expanded(
                    child: Divider(
                      color: const Color(0xffD4AF37).withValues(alpha: 0.3),
                      thickness: 1,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 25,),

              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 6, bottom: 10),
                  child: Text(
                    "ACCOUNT",
                    style: TextStyle(
                      color: Color(0xffD4AF37),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff1B3767),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: [
                      ProfileSettingTile(
                          icon:  Icons.person,
                          title: 'Personal Information',
                          onTap: (){
                            Get.toNamed(RouteName.personalInfo);
                          }
                      ),

                      Divider(height: 1, color: Colors.white12),

                      ProfileSettingTile(
                          icon:  Icons.security,
                          title: 'Security & Privacy',
                          onTap: (){
                            Get.toNamed(RouteName.security);
                          }
                      ),

                      Divider(height: 1, color: Colors.white12),

                      ProfileSettingTile(
                          icon:  Icons.backup_outlined,
                          title: 'Data & Backup',
                          onTap: (){
                            Get.toNamed(RouteName.backup);
                          }
                      ),


                    ],
                  ),
                ),
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 6, bottom: 10),
                  child: Text(
                    "WISDOM SUPPORT",
                    style: TextStyle(
                      color: Color(0xffD4AF37),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff1B3767),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: [
                      ProfileSettingTile(
                          icon:  Icons.info_outline,
                          title: 'Help & FAQs',
                          onTap: (){
                            Get.toNamed(RouteName.helpfaq);
                          }
                      ),

                      Divider(height: 1, color: Colors.white12),

                      ProfileSettingTile(
                          icon:  Icons.help_outline_outlined,
                          title: 'About Us',
                          onTap: (){
                            Get.toNamed(RouteName.about);
                          }
                      ),
                    ],
                  ),
                ),
              ),

          // LOGOUT BUTTON
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 30),
            child: SizedBox(
              width: double.infinity,
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () {
                  Get.dialog(
                    Dialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: const EdgeInsets.symmetric(horizontal: 28),
                      child: Container(
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          color: const Color(0xff1B3767),
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: const Color(0xffD4AF37).withValues(alpha: 0.25),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            // LOGOUT ICON
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.redAccent.withValues(alpha: 0.12),
                              ),
                              child: const Icon(
                                Icons.logout_rounded,
                                color: Colors.redAccent,
                                size: 30,
                              ),
                            ),

                            const SizedBox(height: 18),

                            // TITLE
                            const Text(
                              "Logout",
                              style: TextStyle(
                                color: Color(0xffD4AF37),
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            // MESSAGE
                            const Text(
                              "Are you sure you want to logout\nfrom KrishnaVerse?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),

                            const SizedBox(height: 25),

                            // BUTTONS
                            Row(
                              children: [

                                // CANCEL BUTTON
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    style: OutlinedButton.styleFrom(
                                      minimumSize: const Size(double.infinity, 48),
                                      side: const BorderSide(
                                        color: Colors.white24,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 12),

                                // LOGOUT BUTTON
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {

                                      Get.back();
                                      Get.offAllNamed(
                                        RouteName.loginScreen,
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(double.infinity, 48),
                                      backgroundColor: Colors.redAccent,
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      "Logout",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },

                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: Colors.white12,
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Icon(
                        Icons.logout_rounded,
                        color: Colors.redAccent,
                        size: 22,
                      ),

                      SizedBox(width: 12),

                      Text(
                        "Log Out",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
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