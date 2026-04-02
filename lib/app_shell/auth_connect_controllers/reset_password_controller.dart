import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';

class ResetPasswordController {
  // Controllers
  final currentPassCtrl = TextEditingController();
  final newPassCtrl = TextEditingController();
  final confirmPassCtrl = TextEditingController();
  final secQuestionCtrl = TextEditingController();
  final secAnswerCtrl = TextEditingController();

  // State
  bool isUpdateSecurityQA = false;
  bool isLoading = false;

  // Dispose
  void dispose() {
    currentPassCtrl.dispose();
    newPassCtrl.dispose();
    confirmPassCtrl.dispose();
    secQuestionCtrl.dispose();
    secAnswerCtrl.dispose();
  }

  // Getters
  String get currentPass => currentPassCtrl.text.trim();
  String get newPass => newPassCtrl.text.trim();
  String get confirmPass => confirmPassCtrl.text.trim();
  String get secQuestion => secQuestionCtrl.text.trim();
  String get secAnswer => secAnswerCtrl.text.trim();

  // Validation
  bool get isPasswordValid => newPass.length >= 6;

  bool get isPasswordMatch => newPass == confirmPass;

  bool get isSecurityValid {
    if (!isUpdateSecurityQA) return true;
    return secQuestion.isNotEmpty && secAnswer.isNotEmpty;
  }

  bool get isValid {
    return currentPass.isNotEmpty &&
        isPasswordValid &&
        isPasswordMatch &&
        isSecurityValid;
  }

  // Toggle QA
  void toggleSecurityQA(bool value) {
    isUpdateSecurityQA = value;
    ZiLogger.log("Security QA Toggle: $value");
  }

  // Submit
  Future<void> onSubmit() async {
    ZiLogger.log("Update Password Clicked");

    ZiLogger.log("Current Password: $currentPass");
    ZiLogger.log("New Password: $newPass");
    ZiLogger.log("Confirm Password: $confirmPass");

    if (isUpdateSecurityQA) {
      ZiLogger.log("Security Question: $secQuestion");
      ZiLogger.log("Security Answer: $secAnswer");
    }

    // Validation checks
    if (currentPass.isEmpty) {
      ZiLogger.log("Validation Failed: Current password empty");
      return;
    }

    if (!isPasswordValid) {
      ZiLogger.log("Validation Failed: Password too short");
      return;
    }

    if (!isPasswordMatch) {
      ZiLogger.log("Validation Failed: Password mismatch");
      return;
    }

    if (!isSecurityValid) {
      ZiLogger.log("Validation Failed: Security QA incomplete");
      return;
    }

    try {
      isLoading = true;
      ZiLogger.log("Calling Update Password API...");

      // DO: Replace with real API / Firebase
      await Future.delayed(const Duration(seconds: 2));

      ZiLogger.log("Password Updated Successfully ✅");
    } catch (e) {
      ZiLogger.log("Error: $e");
    } finally {
      isLoading = false;
    }
  }
}
