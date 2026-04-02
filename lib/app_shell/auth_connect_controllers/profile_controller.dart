import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';

class EditProfileController {
  // Controllers
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();

  // State
  bool isLoading = false;

  // Init (Prefill Data)
  void init({
    required String name,
    required String phone,
    required String email,
  }) {
    nameCtrl.text = name;
    phoneCtrl.text = phone;
    emailCtrl.text = email;

    ZiLogger.log("Profile Prefilled");
    ZiLogger.log("Name: $name");
    ZiLogger.log("Phone: $phone");
    ZiLogger.log("Email: $email");
  }

  // Dispose
  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
  }

  // Getters
  String get name => nameCtrl.text.trim();
  String get phone => phoneCtrl.text.trim();
  String get email => emailCtrl.text.trim();

  // Validation
  bool get isValid {
    return name.isNotEmpty && phone.isNotEmpty;
  }

  // Submit
  Future<void> onUpdate() async {
    ZiLogger.log("Update Profile Clicked");

    ZiLogger.log("Updated Name: $name");
    ZiLogger.log("Updated Phone: $phone");
    ZiLogger.log("Email (readonly): $email");

    if (!isValid) {
      ZiLogger.log("Validation Failed: Empty fields");
      return;
    }

    try {
      isLoading = true;
      ZiLogger.log("Calling Update Profile API...");

      // DO: Replace with Firebase / API
      await Future.delayed(const Duration(seconds: 2));

      ZiLogger.log("Profile Updated Successfully ✅");
    } catch (e) {
      ZiLogger.log("Error: $e");
    } finally {
      isLoading = false;
    }
  }
}
