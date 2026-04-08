import 'package:flutter/material.dart';
import 'package:storepool/firebase_services/auth/auth_service.dart';
import 'package:zi_core/zi_core_io.dart';

class ResetPasswordController {
  // ───────────────── Controllers ─────────────────
  final TextEditingController currentPassCtrl = TextEditingController();
  final TextEditingController newPassCtrl = TextEditingController();
  final TextEditingController confirmPassCtrl = TextEditingController();
  final TextEditingController secQuestionCtrl = TextEditingController();
  final TextEditingController secAnswerCtrl = TextEditingController();

  final AuthService _authService = AuthService();

  // ───────────────── State ─────────────────
  bool isUpdateSecurityQA = false;
  bool isLoading = false;

  // ───────────────── INIT ─────────────────
  ResetPasswordController() {
    ZiLogger.log("ResetPasswordController initialized ✅");
  }

  // ───────────────── Dispose ─────────────────
  void dispose() {
    currentPassCtrl.dispose();
    newPassCtrl.dispose();
    confirmPassCtrl.dispose();
    secQuestionCtrl.dispose();
    secAnswerCtrl.dispose();
    ZiLogger.log("ResetPasswordController disposed ✅");
  }

  // ───────────────── Getters ─────────────────
  String get currentPass => currentPassCtrl.text.trim();
  String get newPass => newPassCtrl.text.trim();
  String get confirmPass => confirmPassCtrl.text.trim();
  String get secQuestion => secQuestionCtrl.text.trim();
  String get secAnswer => secAnswerCtrl.text.trim();

  // ───────────────── Validation ─────────────────

  /// Password must be at least 6 chars
  bool get isPasswordValid => newPass.length >= 6;

  /// Password match check (MAIN FEATURE)
  bool get isPasswordMatch => newPass == confirmPass;

  /// Optional: security QA validation
  bool get isSecurityValid =>
      !isUpdateSecurityQA ||
      (secQuestion.isNotEmpty && secAnswer.isNotEmpty);

  /// Final form validation
  bool get isValid =>
      currentPass.isNotEmpty &&
      newPass.isNotEmpty &&
      confirmPass.isNotEmpty &&
      isPasswordValid &&
      isPasswordMatch &&
      isSecurityValid;

  // ───────────────── Actions ─────────────────

  void toggleSecurityQA(bool value) {
    isUpdateSecurityQA = value;
    ZiLogger.log("Security QA Toggle → $value");
  }

  // ───────────────── Submit ─────────────────

  Future<bool> onSubmit() async {
    ZiLogger.log(
        "Reset Password Clicked → Current: $currentPass, New: $newPass");

    // ❌ Stop if invalid
    if (!isValid) {
      ZiLogger.log(
        "Validation Failed ❌ → "
        "currentPass: $currentPass, "
        "newPass: $newPass, "
        "confirmPass: $confirmPass, "
        "match: $isPasswordMatch, "
        "passwordValid: $isPasswordValid, "
        "securityValid: $isSecurityValid",
      );
      return false;
    }

    try {
      isLoading = true;
      ZiLogger.log("Calling Reset Password API... ⏳");

      final result = await _authService.resetPassword(
        currentPassword: currentPass,
        newPassword: newPass,
        updateSecurityQA: isUpdateSecurityQA,
        secQuestion: secQuestion,
        secAnswer: secAnswer,
      );

      if (result) {
        ZiLogger.log("Password Updated Successfully ✅");
      } else {
        ZiLogger.log("Password Update Failed ❌");
      }

      return result;
    } catch (e) {
      ZiLogger.log("Reset Password Exception ❌ → $e");
      return false;
    } finally {
      isLoading = false;
    }
  }
}