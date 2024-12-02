// lib/pages/editProfilePage.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:comic_book_store/controllers/editProfileController.dart';
import 'package:comic_book_store/components/input.dart'; // Import CustomInputField
import 'package:comic_book_store/components/button.dart'; // Import CustomButton

class EditProfilePage extends StatelessWidget {
  final EditProfileController controller = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomInputField(
                  hintText: 'Full Name',
                  controller: controller.fullNameController,
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  hintText: 'Email',
                  controller: controller.emailController,
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  hintText: 'Current Password',
                  controller: controller.currentPasswordController,
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  hintText: 'New Password',
                  controller: controller.newPasswordController,
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  hintText: 'Confirm Password',
                  controller: controller.confirmPasswordController,
                  obscureText: true,
                ),
                const SizedBox(height: 32),
                CustomButton(
                  text: 'Update Profile',
                  onPressed: controller.updateProfile,
                  width: double.infinity,
                  height: 50,
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
