import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/routes_name.dart';
import '../../view_model/login_view_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginViewModel());

    Future<void> login(String email, String password) async {
      if (email.trim().isEmpty || password.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please enter email and password"),
          ),
        );
        return;
      }

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Login Successful"),
            backgroundColor: Colors.green,
          ),
        );

        Get.offAllNamed(RouteName.homeScreen);
      } on FirebaseAuthException catch (e) {
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

          default:
            message = e.message ?? "Login failed";
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xff0A0B22),
      resizeToAvoidBottomInset: false,

      body: Stack(
        children: [
          // ================= BACKGROUND =================
          Positioned.fill(
            child: Image.asset(
              'assets/images/login.png',
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,

              padding: EdgeInsets.only(
                top: 280,
                left: 30,
                right: 30,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),

              child: Align(
                alignment: Alignment.topCenter,

                child: SingleChildScrollView(
                  child: Form(
                    key: controller.formKey,

                    child: Column(
                      children: [

                        const SizedBox(height: 20),

                        // ================= SHLOKA =================
                        const Text(
                          'यदा यदा हि धर्मस्य ग्लानिर्भवति भारत।\n'
                              'अभ्युत्थानमधर्मस्य तदात्मानं सृजाम्यहम्॥',

                          textAlign: TextAlign.center,

                          style: TextStyle(
                            color: Color(0xffD4AF37),
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // ================= SUBTITLE =================
                        const Text(
                          "Whenever righteousness declines,\n"
                              "I manifest Myself",

                          textAlign: TextAlign.center,

                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 30),

                        // ================= EMAIL =================
                        TextFormField(
                          controller: controller.emailController,

                          cursorColor: const Color(0xffD4AF37),

                          style: const TextStyle(
                            color: Colors.white,
                          ),

                          decoration: InputDecoration(
                            hintText: "Email",

                            hintStyle: TextStyle(
                              color: Colors.white.withValues(
                                alpha: 0.45,
                              ),
                              fontSize: 16,
                            ),

                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: Color(0xffD4AF37),
                            ),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),

                              borderSide: BorderSide(
                                color: Colors.white.withValues(
                                  alpha: 0.18,
                                ),
                              ),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),

                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 1.5,
                              ),
                            ),

                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),

                              borderSide: const BorderSide(
                                color: Colors.red,
                              ),
                            ),

                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),

                              borderSide: const BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter Email";
                            }

                            if (!RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$',
                            ).hasMatch(value)) {
                              return "Invalid Email";
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        // ================= PASSWORD =================
                        Obx(
                              () => TextFormField(
                            controller: controller.passwordController,

                            obscureText: controller.obscure.value,

                            cursorColor: const Color(0xffD4AF37),

                            style: const TextStyle(
                              color: Colors.white,
                            ),

                            decoration: InputDecoration(
                              hintText: "Password",

                              hintStyle: TextStyle(
                                color: Colors.white.withValues(
                                  alpha: 0.45,
                                ),
                                fontSize: 16,
                              ),

                              prefixIcon: const Icon(
                                Icons.lock_outline,
                                color: Color(0xffD4AF37),
                              ),

                              suffixIcon: IconButton(
                                onPressed: controller.changeObscure,

                                icon: Icon(
                                  controller.obscure.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,

                                  color: const Color(0xffD4AF37),
                                ),
                              ),

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),

                                borderSide: BorderSide(
                                  color: Colors.white.withValues(
                                    alpha: 0.18,
                                  ),
                                ),
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),

                                borderSide: const BorderSide(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                              ),

                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),

                                borderSide: const BorderSide(
                                  color: Colors.red,
                                ),
                              ),

                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),

                                borderSide: const BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                            ),

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Password";
                              }

                              if (value.length < 6) {
                                return "Password must be 6 characters";
                              }

                              return null;
                            },
                          ),
                        ),

                        // ================= FORGOT PASSWORD =================
                        Align(
                          alignment: Alignment.centerRight,

                          child: TextButton(
                            onPressed: () {
                              Get.toNamed(
                                RouteName.forgotPassword,
                              );
                            },

                            child: const Text(
                              "Forgot Password?",

                              style: TextStyle(
                                color: Color(0xffD4AF37),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 35),

                        // ================= LOGIN BUTTON =================
                        SizedBox(
                          width: double.infinity,
                          height: 55,

                          child: Obx(
                                () => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 8,

                                backgroundColor:
                                const Color(0xffD4AF37),

                                shadowColor:
                                const Color(0xffD4AF37),

                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(18),
                                ),
                              ),

                              onPressed: controller.loading.value
                                  ? null
                                  : () => controller.login(),

                              child: controller.loading.value
                                  ? const SizedBox(
                                height: 20,
                                width: 20,

                                child:
                                CircularProgressIndicator(
                                  color:
                                  Color(0xffD4AF37),
                                  strokeWidth: 2,
                                ),
                              )

                                  : const Text(
                                'LOGIN',

                                style: TextStyle(
                                  color: Color(0xff0A0B22),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // ================= GOOGLE SIGN IN =================
                        SizedBox(
                          width: double.infinity,
                          height: 55,

                          child: OutlinedButton(
                            onPressed: () {
                              controller.googleLogin();
                            },

                            style: OutlinedButton.styleFrom(
                              backgroundColor:
                              Colors.white.withValues(
                                alpha: 0.08,
                              ),

                              side: BorderSide(
                                color: Colors.white.withValues(
                                  alpha: 0.25,
                                ),
                              ),

                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(18),
                              ),
                            ),

                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,

                              children: [
                                Image.asset(
                                  'assets/images/google.png',

                                  height: 24,
                                  width: 24,
                                ),

                                const SizedBox(width: 12),

                                const Text(
                                  'Sign in with Google',

                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // ================= CREATE ACCOUNT =================
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,

                          children: [
                            const Text(
                              "Don't have an account? ",

                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 15,
                              ),
                            ),

                            InkWell(
                              onTap: () {
                                Get.toNamed(
                                  RouteName.signupScreen,
                                );
                              },

                              child: const Text(
                                "Create Account",

                                style: TextStyle(
                                  color: Color(0xffD4AF37),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//unnecessary comment