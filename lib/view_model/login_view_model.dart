import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../repository/login_repository.dart';
import '../routes/routes_name.dart';

class LoginViewModel extends GetxController {
  RxBool obscure = true.obs;
  RxBool loading = false.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final LoginRepository _repository = LoginRepository();

  // Show / Hide Password
  void changeObscure() {
    obscure.value = !obscure.value;
  }

  // ================= LOGIN =================

  Future<void> login() async {
    // Validate form
    if (!formKey.currentState!.validate()) {
      return;
    }

    loading.value = true;

    try {
      // Firebase Login
      await _repository.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      loading.value = false;

      // Login successful
      Get.snackbar(
        "Success",
        "Login Successful",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Go to Home
      Get.offAllNamed(RouteName.homeScreen);
    } on FirebaseAuthException catch (e) {
      loading.value = false;

      String message;

      switch (e.code) {
        case "user-not-found":
          message = "No account found with this email";
          break;

        case "wrong-password":
          message = "Incorrect password";
          break;

        case "invalid-email":
          message = "Invalid email address";
          break;

        case "invalid-credential":
          message = "Invalid email or password";
          break;

        case "user-disabled":
          message = "This account has been disabled";
          break;

        default:
          message = e.message ?? "Login failed";
      }

      Get.snackbar(
        "Login Failed",
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      loading.value = false;

      Get.snackbar(
        "Error",
        "Something went wrong",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // ================= GOOGLE LOGIN =================




  // ================= GOOGLE LOGIN =================

  Future<void> googleLogin() async {
    loading.value = true;

    try {
      // Google Login through Repository
      final UserCredential? userCredential =
      await _repository.googleLogin();

      // User ne Google Picker ko Back / Cancel kiya
      if (userCredential == null) {
        loading.value = false;

        return;
      }

      // Google Login successful
      loading.value = false;

      Get.snackbar(
        "Success",
        "Google Login Successful",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Go to Home
      Get.offAllNamed(RouteName.homeScreen);
    } on FirebaseAuthException catch (e) {
      loading.value = false;

      Get.snackbar(
        "Google Login Failed",
        e.message ?? "Google Login failed",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      loading.value = false;

      Get.snackbar(
        "Google Login Failed",
        "Something went wrong",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // ================= FORGOT PASSWORD =================

  Future<void> forgotPassword(String email) async {
    try {
      // Send password reset email through Firebase
      await _repository.forgotPassword(
        email.trim(),
      );

      Get.snackbar(
        "Success",
        "Password reset link sent to your email",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Wait for 2 seconds
      await Future.delayed(
        const Duration(seconds: 2),
      );

      // Go back to Login screen
      if (Get.isOverlaysOpen) {
        Get.back();
      }
    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case "invalid-email":
          message = "Invalid email address";
          break;

        case "user-not-found":
          message = "No account found with this email";
          break;

        case "user-disabled":
          message = "This account has been disabled";
          break;

        default:
          message = e.message ?? "Failed to send reset link";
      }

      Get.snackbar(
        "Reset Password Failed",
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // ================= DISPOSE =================

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();

    super.onClose();
  }
}