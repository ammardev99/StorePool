import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:storepool/firebase_services/auth/auth_service.dart';
import 'package:zi_core/zi_core_io.dart';
class EditProfileController {
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();

  bool isLoading = false;

  void init({required String name, required String phone, required String email}) {
    nameCtrl.text = name;
    phoneCtrl.text = phone;
    emailCtrl.text = email;
  }

  bool get isValid => nameCtrl.text.trim().isNotEmpty && phoneCtrl.text.trim().isNotEmpty;

  String get name => nameCtrl.text.trim();
  String get phone => phoneCtrl.text.trim();

  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
  }

  // 🔥 Updated method returning bool
  Future<bool> onUpdate() async {
    if (!isValid) return false;

    try {
      isLoading = true;

      final user = AuthService().currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'name': name,
          'phone': phone,
        });
        return true; // success
      }
      return false;
    } catch (e) {
      ZiLogger.log("Error updating profile: $e");
      return false;
    } finally {
      isLoading = false;
    }
  }
}