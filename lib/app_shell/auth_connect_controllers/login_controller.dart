import 'package:flutter/material.dart';
import 'package:storepool/app_services/auth/auth_service.dart';
import 'package:zi_core/zi_core_io.dart';

class LoginController {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  final AuthService _authService = AuthService();

  bool isLoading = false;

  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    ZiLogger.log("LoginController disposed ✅");
  }

  String get email => emailCtrl.text.trim();
  String get password => passwordCtrl.text.trim();

  bool get isValid => email.isNotEmpty && password.isNotEmpty;
  bool get isEmailValid => email.contains("@");

  Future<bool> onLogin() async {
    ZiLogger.log("Login Button Clicked → Email: $email");

    if (!isValid || !isEmailValid) {
      ZiLogger.log("Validation Failed ❌ → email: $email, password: ${password.isNotEmpty}");
      return false;
    }

    try {
      isLoading = true;
      final result = await _authService.loginUser(email: email, password: password);
      ZiLogger.log(result ? "Login Success ✅" : "Login Failed ❌");
      return result;
    } finally {
      isLoading = false;
    }
  }
}