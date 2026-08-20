import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/routes_name.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // ================= CONTROLLERS =================

  final TextEditingController nameController =
  TextEditingController();

  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  final TextEditingController confirmPasswordController =
  TextEditingController();

  // ================= VARIABLES =================

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool agreedToTerms = false;

  // ================= SIGN UP =================

  Future<void> signUp(
      String name,
      String email,
      String password,
      ) async {
    if (name.trim().isEmpty ||
        email.trim().isEmpty ||
        password.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all required fields"),
        ),
      );
      return;
    }

    try {
      // ================= CREATE FIREBASE USER =================

      final UserCredential credential =
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // ================= SAVE NAME =================

      await credential.user?.updateDisplayName(
        name.trim(),
      );

      // Refresh Firebase user data
      await credential.user?.reload();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Signup Successful"),
          backgroundColor: Colors.green,
        ),
      );

      // ================= GO TO HOME =================

      Get.offAllNamed(RouteName.homeScreen);
    }

    // ================= FIREBASE ERROR =================

    on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case "email-already-in-use":
          message = "Email already exists";
          break;

        case "weak-password":
          message = "Password should be at least 6 characters";
          break;

        case "invalid-email":
          message = "Invalid email address";
          break;

        case "user-disabled":
          message = "This account has been disabled";
          break;

        default:
          message = e.message ?? "Something went wrong";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    }

    // ================= OTHER ERROR =================

    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Something went wrong"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // ================= DISPOSE =================

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0A0B22),
      resizeToAvoidBottomInset: false,

      body: Stack(
        children: [
          // ================= BACKGROUND IMAGE =================

          Positioned.fill(
            child: Image.asset(
              'assets/images/signup.png',
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,

              padding: EdgeInsets.only(
                top: 250,
                left: 30,
                right: 30,
                bottom:
                MediaQuery.of(context).viewInsets.bottom,
              ),

              child: Align(
                alignment: Alignment.topCenter,

                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,

                    child: Column(
                      children: [
                        // ================= TITLE =================

                        const Text(
                          "Begin Your Journey",
                          textAlign: TextAlign.center,

                          style: TextStyle(
                            color: Color(0xffD4AF37),
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // ================= NAME =================

                        TextFormField(
                          controller: nameController,

                          cursorColor:
                          const Color(0xffD4AF37),

                          style: const TextStyle(
                            color: Colors.white,
                          ),

                          decoration: InputDecoration(
                            hintText: "Name",

                            hintStyle: TextStyle(
                              color: Colors.white
                                  .withOpacity(0.5),
                            ),

                            prefixIcon: const Icon(
                              Icons.person_outline,
                              color: Color(0xffD4AF37),
                            ),

                            enabledBorder:
                            OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(18),

                              borderSide: BorderSide(
                                color: Colors.white
                                    .withOpacity(0.2),
                              ),
                            ),

                            focusedBorder:
                            OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(18),

                              borderSide:
                              const BorderSide(
                                color: Colors.white,
                              ),
                            ),

                            errorBorder:
                            OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(18),

                              borderSide:
                              const BorderSide(
                                color: Colors.red,
                              ),
                            ),

                            focusedErrorBorder:
                            OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(18),

                              borderSide:
                              const BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),

                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return "Enter Name";
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        // ================= EMAIL =================

                        TextFormField(
                          controller: emailController,

                          cursorColor:
                          const Color(0xffD4AF37),

                          style: const TextStyle(
                            color: Colors.white,
                          ),

                          decoration: InputDecoration(
                            hintText: "Email",

                            hintStyle: TextStyle(
                              color: Colors.white
                                  .withOpacity(0.5),
                            ),

                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: Color(0xffD4AF37),
                            ),

                            enabledBorder:
                            OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(18),

                              borderSide: BorderSide(
                                color: Colors.white
                                    .withOpacity(0.2),
                              ),
                            ),

                            focusedBorder:
                            OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(18),

                              borderSide:
                              const BorderSide(
                                color: Colors.white,
                              ),
                            ),

                            errorBorder:
                            OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(18),

                              borderSide:
                              const BorderSide(
                                color: Colors.red,
                              ),
                            ),

                            focusedErrorBorder:
                            OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(18),

                              borderSide:
                              const BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),

                          validator: (value) {
                            if (value == null ||
                                value.isEmpty) {
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

                        TextFormField(
                          controller: passwordController,

                          obscureText: obscurePassword,

                          cursorColor:
                          const Color(0xffD4AF37),

                          style: const TextStyle(
                            color: Colors.white,
                          ),

                          decoration: InputDecoration(
                            hintText: "Password",

                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: Color(0xffD4AF37),
                            ),

                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscurePassword =
                                  !obscurePassword;
                                });
                              },

                              icon: Icon(
                                obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,

                                color:
                                const Color(0xffD4AF37),
                              ),
                            ),

                            enabledBorder:
                            OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(18),

                              borderSide: BorderSide(
                                color: Colors.white
                                    .withOpacity(0.2),
                              ),
                            ),

                            focusedBorder:
                            OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(18),

                              borderSide:
                              const BorderSide(
                                color: Colors.white,
                              ),
                            ),

                            errorBorder:
                            OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(18),

                              borderSide:
                              const BorderSide(
                                color: Colors.red,
                              ),
                            ),

                            focusedErrorBorder:
                            OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(18),

                              borderSide:
                              const BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),

                          validator: (value) {
                            if (value == null ||
                                value.isEmpty) {
                              return "Enter Password";
                            }

                            if (value.length < 6) {
                              return "Password must be at least 6 characters";
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        // ================= CONFIRM PASSWORD =================

                        TextFormField(
                          controller:
                          confirmPasswordController,

                          obscureText:
                          obscureConfirmPassword,

                          cursorColor:
                          const Color(0xffD4AF37),

                          style: const TextStyle(
                            color: Colors.white,
                          ),

                          decoration: InputDecoration(
                            hintText: "Confirm Password",

                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: Color(0xffD4AF37),
                            ),

                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscureConfirmPassword =
                                  !obscureConfirmPassword;
                                });
                              },

                              icon: Icon(
                                obscureConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,

                                color:
                                const Color(0xffD4AF37),
                              ),
                            ),

                            enabledBorder:
                            OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(18),

                              borderSide: BorderSide(
                                color: Colors.white
                                    .withOpacity(0.2),
                              ),
                            ),

                            focusedBorder:
                            OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(18),

                              borderSide:
                              const BorderSide(
                                color: Colors.white,
                              ),
                            ),

                            errorBorder:
                            OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(18),

                              borderSide:
                              const BorderSide(
                                color: Colors.red,
                              ),
                            ),

                            focusedErrorBorder:
                            OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(18),

                              borderSide:
                              const BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),

                          validator: (value) {
                            if (value == null ||
                                value.isEmpty) {
                              return "Confirm your password";
                            }

                            if (value !=
                                passwordController.text) {
                              return "Passwords do not match";
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        // ================= TERMS =================

                        Row(
                          children: [
                            Checkbox(
                              value: agreedToTerms,

                              activeColor:
                              const Color(0xffD4AF37),

                              onChanged: (value) {
                                setState(() {
                                  agreedToTerms =
                                      value ?? false;
                                });
                              },
                            ),

                            const Expanded(
                              child: Text(
                                "I agree to the Terms & Conditions and Privacy Policy",

                                style: TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        // ================= SIGN UP BUTTON =================

                        SizedBox(
                          width: double.infinity,
                          height: 55,

                          child: ElevatedButton(
                            style:
                            ElevatedButton.styleFrom(
                              backgroundColor:
                              const Color(0xffD4AF37),

                              shape:
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(18),
                              ),
                            ),

                            onPressed: () async {
                              // Check Terms
                              if (!agreedToTerms) {
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Please accept Terms & Conditions",
                                    ),
                                  ),
                                );

                                return;
                              }

                              // Validate form
                              if (_formKey.currentState!
                                  .validate()) {
                                await signUp(
                                  nameController.text,
                                  emailController.text,
                                  passwordController.text,
                                );
                              }
                            },

                            child: const Text(
                              "Sign Up",

                              style: TextStyle(
                                color: Color(0xff0A0B22),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // ================= LOGIN =================

                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,

                          children: [
                            const Text(
                              "Already have an account?",

                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),

                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },

                              child: const Text(
                                "Login",

                                style: TextStyle(
                                  color: Color(0xffD4AF37),
                                  fontWeight: FontWeight.bold,
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