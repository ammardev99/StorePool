import 'package:flutter/material.dart';
import 'package:storepool/app_services/auth/auth_service.dart';
import 'package:zi_core/zi_core_io.dart';

class SignupController {
  // ─── Text Controllers ─────────────────────────────
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final secQCtrl = TextEditingController();
  final secACtrl = TextEditingController();

  // ─── Auth Service ────────────────────────────────
  final AuthService _authService = AuthService();

  // ─── State ──────────────────────────────────────
  bool agreedToTerms = false;
  bool isLoading = false;

  // ─── Constructor
  SignupController() {
    ZiLogger.log("SignupController Initialized ✅");
  }

  // ─── Dispose
  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    secQCtrl.dispose();
    secACtrl.dispose();
    ZiLogger.log("SignupController Disposed 🗑️");
  }

  // ─── Getters ─────────────────────────────────────
  String get name => nameCtrl.text.trim();
  String get phone => phoneCtrl.text.trim();
  String get email => emailCtrl.text.trim();
  String get password => passwordCtrl.text.trim();
  String get secQ => secQCtrl.text.trim();
  String get secA => secACtrl.text.trim();

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

  void toggleTerms(bool value) {
    agreedToTerms = value;
    ZiLogger.log("Terms Accepted: $value");
  }

  // ─── Signup Function ─────────────────────────────
  Future<bool> onSignup() async {
    ZiLogger.log("Signup Button Clicked");

    if (!isValid) {
      ZiLogger.log("Validation Failed ❌");
      return false;
    }

    isLoading = true;

    try {
      final result = await _authService.signupUser(
        name: name,
        phone: phone,
        email: email,
        password: password,
        secQ: secQ,
        secA: secA,
      );

      isLoading = false;

      if (result) {
        ZiLogger.log("Signup Success ✅");
        return true;
      } else {
        ZiLogger.log("Signup Failed ❌: User not registered");
        return false;
      }
    } catch (e, stackTrace) {
      ZiLogger.log("Error during signup ❌: $e");
      ZiLogger.log(stackTrace.toString());
      isLoading = false;
      return false;
    }
  }
}