import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';

class SignupController {
  // Controllers
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final secQCtrl = TextEditingController();
  final secACtrl = TextEditingController();

  // State
  bool agreedToTerms = false;
  bool isLoading = false;

  // Dispose
  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    secQCtrl.dispose();
    secACtrl.dispose();
  }

  // Getters
  String get name => nameCtrl.text.trim();
  String get phone => phoneCtrl.text.trim();
  String get email => emailCtrl.text.trim();
  String get password => passwordCtrl.text.trim();
  String get secQ => secQCtrl.text.trim();
  String get secA => secACtrl.text.trim();

  // Validation
  bool get isEmailValid => email.contains("@");
  bool get isPasswordValid => password.length >= 6;

  bool get isValid {
    return name.isNotEmpty &&
        phone.isNotEmpty &&
        email.isNotEmpty &&
        isEmailValid &&
        isPasswordValid &&
        secQ.isNotEmpty &&
        secA.isNotEmpty &&
        agreedToTerms;
  }

  // Toggle Terms
  void toggleTerms(bool value) {
    agreedToTerms = value;
    ZiLogger.log("Terms Accepted: $value");
  }

  // Submit
  Future<bool> onSignup() async {
    ZiLogger.log("Signup Button Clicked");

    ZiLogger.log("Name: $name");
    ZiLogger.log("Phone: $phone");
    ZiLogger.log("Email: $email");
    ZiLogger.log("Password: $password");
    ZiLogger.log("Security Question: $secQ");
    ZiLogger.log("Security Answer: $secA");
    ZiLogger.log("Agreed To Terms: $agreedToTerms");

    if (!isValid) {
      ZiLogger.log("Validation Failed");
      return false;
    }

    try {
      isLoading = true;
      ZiLogger.log("Calling Signup API...");

      // TODO: Replace with Firebase/Auth API
      await Future.delayed(const Duration(seconds: 2));

      ZiLogger.log("Signup Success ✅");
      return true;
    } catch (e) {
      ZiLogger.log("Signup Error: $e");
      return false;
    } finally {
      isLoading = false;
    }
  }
}
