import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:comic_book_store/routes/appRoutes.dart';

class SignOutController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign out user
  Future<void> signOutUser() async {
    try {
      await _auth.signOut();
      Get.offAllNamed(AppRoutes.ONBOARDING);
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred while signing out. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}