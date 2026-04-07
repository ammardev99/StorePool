import 'package:flutter/material.dart';
import 'package:storepool/app_services/auth/auth_service.dart';
import 'package:zi_core/zi_core_io.dart';

class ResetPasswordController {
  final TextEditingController currentPassCtrl = TextEditingController();
  final TextEditingController newPassCtrl = TextEditingController();
  final TextEditingController confirmPassCtrl = TextEditingController();
  final TextEditingController secQuestionCtrl = TextEditingController();
  final TextEditingController secAnswerCtrl = TextEditingController();

  final AuthService _authService = AuthService();

  bool isUpdateSecurityQA = false;
  bool isLoading = false;

  // INIT
  ResetPasswordController() {
    ZiLogger.log("ResetPasswordController initialized ✅");
  }

  void dispose() {
    currentPassCtrl.dispose();
    newPassCtrl.dispose();
    confirmPassCtrl.dispose();
    secQuestionCtrl.dispose();
    secAnswerCtrl.dispose();
    ZiLogger.log("ResetPasswordController disposed ✅");
  }

  String get currentPass => currentPassCtrl.text.trim();
  String get newPass => newPassCtrl.text.trim();
  String get confirmPass => confirmPassCtrl.text.trim();
  String get secQuestion => secQuestionCtrl.text.trim();
  String get secAnswer => secAnswerCtrl.text.trim();

  bool get isPasswordValid => newPass.length >= 6;
  bool get isPasswordMatch => newPass == confirmPass;

  bool get isSecurityValid =>
      !isUpdateSecurityQA ||
      (secQuestion.isNotEmpty && secAnswer.isNotEmpty);

  bool get isValid =>
      currentPass.isNotEmpty &&
      isPasswordValid &&
      isPasswordMatch &&
      isSecurityValid;

  void toggleSecurityQA(bool value) {
    isUpdateSecurityQA = value;
    ZiLogger.log("Security QA Toggle → $value");
  }

  Future<bool> onSubmit() async {
    ZiLogger.log(
        "Reset Password Clicked → Current: $currentPass, New: $newPass");

    if (!isValid) {
      ZiLogger.log(
          "Validation Failed ❌ → currentPass: $currentPass, newPass: $newPass, confirmPass: $confirmPass, securityValid: $isSecurityValid");
      return false;
    }

    try {
      isLoading = true;

      final result = await _authService.resetPassword(
        currentPassword: currentPass,
        newPassword: newPass,
        updateSecurityQA: isUpdateSecurityQA,
        secQuestion: secQuestion,
        secAnswer: secAnswer,
      );

      ZiLogger.log(result
          ? "Password Updated Successfully ✅"
          : "Password Update Failed ❌");

      return result;
    } catch (e) {
      ZiLogger.log("Reset Password Exception ❌ → $e");
      return false;
    } finally {
      isLoading = false;
    }
  }
}