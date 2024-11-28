// edit_profile_controller.dart
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool showPassword = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void loadUserData() {
    final user = _auth.currentUser;
    if (user != null) {
      emailController.text = user.email ?? '';
      _firestore.collection('users').doc(user.uid).get().then((doc) {
        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;
          fullNameController.text = data['fullName'] ?? '';
        }
      });
    }
  }

  Future<void> updateProfile() async {
    if (!_validateInputs()) return;

    try {
      isLoading.value = true;
      final user = _auth.currentUser;
      if (user == null) return;

      // Update display name if changed
      if (fullNameController.text.isNotEmpty) {
        await _firestore.collection('users').doc(user.uid).update({
          'fullName': fullNameController.text,
        });
      }

      // Update email if changed
      if (emailController.text != user.email) {
        await user.verifyBeforeUpdateEmail(emailController.text);
      }

      // Update password if provided
      if (currentPasswordController.text.isNotEmpty &&
          newPasswordController.text.isNotEmpty) {
        final credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPasswordController.text,
        );
        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(newPasswordController.text);
      }

      Get.snackbar(
        'Success',
        'Profile updated successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  bool _validateInputs() {
    if (fullNameController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your full name');
      return false;
    }

    if (emailController.text.isEmpty ||
        !GetUtils.isEmail(emailController.text)) {
      Get.snackbar('Error', 'Please enter a valid email');
      return false;
    }

    if (currentPasswordController.text.isNotEmpty ||
        newPasswordController.text.isNotEmpty ||
        confirmPasswordController.text.isNotEmpty) {
      if (currentPasswordController.text.isEmpty) {
        Get.snackbar('Error', 'Please enter your current password');
        return false;
      }
      if (newPasswordController.text.isEmpty) {
        Get.snackbar('Error', 'Please enter a new password');
        return false;
      }
      if (newPasswordController.text != confirmPasswordController.text) {
        Get.snackbar('Error', 'Passwords do not match');
        return false;
      }
      if (newPasswordController.text.length < 6) {
        Get.snackbar('Error', 'Password must be at least 6 characters');
        return false;
      }
    }

    return true;
  }
}
