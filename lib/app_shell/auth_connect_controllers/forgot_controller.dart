// can you give me a controler for the this page
// you can also use this in functions
// ZiLogger.log("msg"); // ass debug print so we can track the user actions or reponse
// for now you can also show data in loger to when i click on submit i show my entrrred Data,
// we also apdate the ui to link with this controllers

// -------------------------

import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';

class ForgotController {
  // Controllers
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();

  // State
  bool isLoading = false;

  // Dispose
  void dispose() {
    emailCtrl.dispose();
    phoneCtrl.dispose();
  }

  // Validation
  bool get isValid {
    return emailCtrl.text.isNotEmpty || phoneCtrl.text.isNotEmpty;
  }

  // Submit Action
  Future<void> onSubmit() async {
    ZiLogger.log("Forgot Password Submit Clicked");

    final email = emailCtrl.text.trim();
    final phone = phoneCtrl.text.trim();

    ZiLogger.log("Entered Email: $email");
    ZiLogger.log("Entered Phone: $phone");

    if (!isValid) {
      ZiLogger.log("Validation Failed: Empty Fields");
      return;
    }

    try {
      isLoading = true;
      ZiLogger.log("Processing request...");

      // DO: API call here
      await Future.delayed(const Duration(seconds: 2));

      ZiLogger.log("Request Success");
    } catch (e) {
      ZiLogger.log("Error: $e");
    } finally {
      isLoading = false;
    }
  }
}
