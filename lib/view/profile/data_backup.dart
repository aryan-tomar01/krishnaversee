import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishnaversee/view/profile/profile_setting_tile.dart';

import '../../routes/routes_name.dart';

class DataBackup extends StatefulWidget {
  const DataBackup({super.key});

  @override
  State<DataBackup> createState() => _DataBackupState();
}

class _DataBackupState extends State<DataBackup> {
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
          "Data & Backup",
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
              "BACKUP",
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
                    icon: Icons.cloud_upload_outlined,
                    title: "Backup Progress",
                    onTap: () {
                      Get.toNamed(RouteName.backupProgress);
                    },
                  ),

                  const Divider(
                    height: 1,
                    color: Colors.white12,
                  ),

                  ProfileSettingTile(
                    icon: Icons.cleaning_services_outlined,
                    title: "Clear Cache",
                    onTap: () {
                      Get.toNamed(RouteName.clearCache);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "BACKUP STATUS",
              style: TextStyle(
                color: Color(0xffD4AF37),
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xff1B3767),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [
                      Icon(
                        Icons.cloud_done,
                        color: Color(0xffD4AF37),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Last Backup",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  Text(
                    "No backup available",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
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