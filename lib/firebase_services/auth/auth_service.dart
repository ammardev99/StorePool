// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zi_core/zi_core_io.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // =========================================================
  // ✅ SIGNUP (WITH STRUCTURED USER DATA)
  // =========================================================
  Future<bool> signupUser({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String secQ,
    required String secA,
  }) async {
    ZiLogger.log("AuthService → signupUser() called");

    try {
      // 1️⃣ Create Firebase user
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        ZiLogger.log("Signup Failed ❌ User is null");
        return false;
      }

      ZiLogger.log("Firebase Auth Success: ${user.uid}");

      // 2️⃣ Save structured user data
      await _firestore.collection('users').doc(user.uid).set({
        'profile': {
          'name': name,
          'email': email,
          'phone': phone,
          'image': null,
        },
        'subscription_plan': 'free',
        'stores_owned': [],
        'hasStore': false,
        'role': 'user', // default role
        'security_question': secQ,
        'security_answer': secA,
        'created_at': FieldValue.serverTimestamp(),
      });

      ZiLogger.log("User created with structured schema ✅");
      return true;
    } on FirebaseAuthException catch (e) {
      ZiLogger.log("FirebaseAuth Error: ${e.message}");
      return false;
    } catch (e) {
      ZiLogger.log("Signup Error: $e");
      return false;
    }
  }

  // =========================================================
  // ✅ LOGIN
  // =========================================================
  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    ZiLogger.log("AuthService → loginUser() called");

    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;
      if (user == null) {
        ZiLogger.log("Login Failed ❌ User null");
        return false;
      }

      ZiLogger.log("Login Success ✅ UID: ${user.uid}");
      return true;
    } on FirebaseAuthException catch (e) {
      ZiLogger.log("FirebaseAuth Error: ${e.message}");
      return false;
    } catch (e) {
      ZiLogger.log("Login Error: $e");
      return false;
    }
  }

  // =========================================================
  // ✅ SEND PASSWORD RESET EMAIL
  // =========================================================
  Future<bool> sendResetEmail({required String email}) async {
    ZiLogger.log("AuthService → sendResetEmail() called");

    try {
      await _auth.sendPasswordResetEmail(email: email);
      ZiLogger.log("Reset Email Sent ✅");
      return true;
    } on FirebaseAuthException catch (e) {
      ZiLogger.log("FirebaseAuth Error: ${e.message}");
      return false;
    } catch (e) {
      ZiLogger.log("Forgot Password Error: $e");
      return false;
    }
  }

  // =========================================================
  // ✅ RESET PASSWORD FOR LOGGED-IN USER
  // =========================================================
  Future<bool> resetPassword({
    required String currentPassword,
    required String newPassword,
    bool updateSecurityQA = false,
    String? secQuestion,
    String? secAnswer,
  }) async {
    ZiLogger.log("AuthService → resetPassword() called");

    try {
      final user = _auth.currentUser;
      if (user == null) return false;

      final email = user.email;
      if (email == null) return false;

      // Re-authenticate
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: currentPassword);
      await user.reauthenticateWithCredential(credential);

      // Update password
      await user.updatePassword(newPassword);

      // Optional security QA update
      if (updateSecurityQA && secQuestion != null && secAnswer != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'security_question': secQuestion,
          'security_answer': secAnswer,
        });
      }

      ZiLogger.log("Password reset successful ✅");
      return true;
    } on FirebaseAuthException catch (e) {
      ZiLogger.log("FirebaseAuth Error: ${e.message}");
      return false;
    } catch (e) {
      ZiLogger.log("Reset Password Error: $e");
      return false;
    }
  }

  // =========================================================
  // ✅ LOGOUT
  // =========================================================
  Future<void> logout() async {
    ZiLogger.log("Logout called");
    await _auth.signOut();
  }

  // =========================================================
  // ✅ CURRENT USER
  // =========================================================
  User? get currentUser => _auth.currentUser;

  // =========================================================
  // ✅ GET USER DATA
  // =========================================================
  Future<Map<String, dynamic>?> getUserData() async {
    ZiLogger.log("AuthService → getUserData() called");

    try {
      final user = _auth.currentUser;
      if (user == null) return null;

      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (!doc.exists) return null;

      return doc.data();
    } catch (e) {
      ZiLogger.log("GetUserData Error: $e");
      return null;
    }
  }
}