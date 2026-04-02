
import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';

class LoginController {
  // Controllers
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  // State
  bool isLoading = false;

  // Dispose
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
  }

  // Getters
  String get email => emailCtrl.text.trim();
  String get password => passwordCtrl.text.trim();

  bool get isValid => email.isNotEmpty && password.isNotEmpty;

  // Validation (basic for now)
  bool get isEmailValid => email.contains("@");

  // Submit
  Future<void> onLogin() async {
    ZiLogger.log("Login Button Clicked");

    ZiLogger.log("Email Entered: $email");
    ZiLogger.log("Password Entered: $password");

    if (!isValid) {
      ZiLogger.log("Validation Failed: Empty fields");
      return;
    }

    if (!isEmailValid) {
      ZiLogger.log("Validation Failed: Invalid Email");
      return;
    }

    try {
      isLoading = true;
      ZiLogger.log("Login API Calling...");

      // DO: Replace with Firebase/Auth API
      await Future.delayed(const Duration(seconds: 2));

      ZiLogger.log("Login Success ✅");
    } catch (e) {
      ZiLogger.log("Login Error: $e");
    } finally {
      isLoading = false;
    }
  }
}
