import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'custom_text_field.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  final TextEditingController currentPasswordController =
  TextEditingController();

  final TextEditingController newPasswordController =
  TextEditingController();

  final TextEditingController confirmPasswordController =
  TextEditingController();

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
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
          "Change Password",
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

            CustomTextField(
              controller: currentPasswordController,
              label: "Current Password",
              hintText: "Enter current password",
              prefixIcon: Icons.lock_outline,
              obscureText: true,
            ),

            const SizedBox(height: 20),

            CustomTextField(
              controller: newPasswordController,
              label: "New Password",
              hintText: "Enter new password",
              prefixIcon: Icons.lock_reset,
              obscureText: true,
            ),

            const SizedBox(height: 20),

            CustomTextField(
              controller: confirmPasswordController,
              label: "Confirm Password",
              hintText: "Re-enter new password",
              prefixIcon: Icons.lock,
              obscureText: true,
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // Change Password Logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffD4AF37),
                  foregroundColor: const Color(0xff142B56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Update Password",
                  style: TextStyle(
                    fontSize: 16,
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