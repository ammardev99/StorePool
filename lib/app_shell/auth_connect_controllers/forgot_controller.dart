import 'package:flutter/material.dart';
import 'package:storepool/app_services/auth/auth_service.dart';
import 'package:zi_core/zi_core_io.dart';

class ForgotController {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();

  final AuthService _authService = AuthService();

  bool isLoading = false;

  void dispose() {
    emailCtrl.dispose();
    phoneCtrl.dispose();
    ZiLogger.log("ForgotController disposed ✅");
  }

  // Validation: either email or phone must be provided
  bool get isValid =>
      emailCtrl.text.trim().isNotEmpty || phoneCtrl.text.trim().isNotEmpty;

  Future<bool> onSubmit() async {
    final email = emailCtrl.text.trim();
    final phone = phoneCtrl.text.trim();

    ZiLogger.log("Forgot Password Clicked → Email: $email, Phone: $phone");

    if (!isValid) {
      ZiLogger.log("Validation Failed ❌ → email: '$email', phone: '$phone'");
      return false;
    }

    try {
      isLoading = true;

      // If email is provided, send reset email
      if (email.isNotEmpty) {
        final result = await _authService.sendResetEmail(email: email);
        ZiLogger.log(result ? "Reset Email Sent ✅" : "Reset Email Failed ❌");
        return result;
      }

      // Optional: handle phone-based flow if needed
      if (phone.isNotEmpty) {
        ZiLogger.log("Phone reset not implemented yet ❌ → phone: $phone");
        return false;
      }

      return false;
    } catch (e) {
      ZiLogger.log("Forgot Password Error: $e ❌");
      return false;
    } finally {
      isLoading = false;
    }
  }
}