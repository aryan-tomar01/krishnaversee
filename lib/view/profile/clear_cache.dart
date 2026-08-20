import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClearCache extends StatefulWidget {
  const ClearCache({super.key});

  @override
  State<ClearCache> createState() => _ClearCacheState();
}

class _ClearCacheState extends State<ClearCache> {
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
          "Clear Cache",
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
              Icons.cleaning_services_outlined,
              size: 70,
              color: Color(0xffD4AF37),
            ),

            const SizedBox(height: 25),

            const Text(
              "Clear Cached Data",
              style: TextStyle(
                color: Color(0xffD4AF37),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              "Clearing cache removes temporary files stored on your device. Your account and reading progress will not be affected.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
                height: 1.5,
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  Get.defaultDialog(
                    title: "Clear Cache",
                    titleStyle: const TextStyle(
                      color: Color(0xffD4AF37),
                    ),
                    middleText:
                    "Are you sure you want to clear cached data?",
                    backgroundColor: const Color(0xff1B3767),
                    textCancel: "Cancel",
                    textConfirm: "Clear",
                    confirmTextColor: Colors.white,
                    buttonColor: Colors.redAccent,
                    onConfirm: () {

                      Get.back();

                      Get.snackbar(
                        "Success",
                        "Cache cleared successfully.",
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                    },
                  );
                },
                child: const Text(
                  "Clear Cache",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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