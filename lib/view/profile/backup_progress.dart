import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackupProgress extends StatefulWidget {
  const BackupProgress({super.key});

  @override
  State<BackupProgress> createState() => _BackupProgressState();
}

class _BackupProgressState extends State<BackupProgress> {
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
          "Backup Progress",
          style: TextStyle(
            color: Color(0xffD4AF37),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const Icon(
              Icons.cloud_done_outlined,
              size: 70,
              color: Color(0xffD4AF37),
            ),

            const SizedBox(height: 25),

            const Text(
              "Cloud Backup",
              style: TextStyle(
                color: Color(0xffD4AF37),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

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

                  Text(
                    "Backup Status",
                    style: TextStyle(
                      color: Color(0xffD4AF37),
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 12),

                  Text(
                    "Last Backup",
                    style: TextStyle(color: Colors.white70),
                  ),

                  SizedBox(height: 5),

                  Text(
                    "No backup available",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffD4AF37),
                  foregroundColor: const Color(0xff142B56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {

                  // TODO: Firebase Backup

                  Get.snackbar(
                    "Backup",
                    "Backup feature will be available soon.",
                    backgroundColor: const Color(0xff1B3767),
                    colorText: Colors.white,
                  );
                },
                child: const Text(
                  "Backup Now",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}